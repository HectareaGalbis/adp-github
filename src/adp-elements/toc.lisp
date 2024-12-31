
(in-package #:adp-github)


;; ------ table-of-contents ------
(defclass table-of-contents ()
  ((min-level :initarg :min-level)
   (max-level :initarg :max-level)
   (include :initarg :include)
   (exclude :initarg :exclude))
  (:documentation
   "Represents a table of contents."))

(defun table-of-contents% (&key (min-level 0) (max-level 2) (include nil) (exclude nil))
  (check-type min-level number)
  (check-type max-level number)
  (let ((problematic-tags (intersection include exclude)))
    (when problematic-tags
      (error "Error: The following tags were found in both include and exclude lists: ~s"
             problematic-tags)))
  (make-instance 'table-of-contents :min-level min-level :max-level max-level
                                    :include include :exclude exclude))

(adp:defmacro table-of-contents (:min-level (min-level 0) :max-level (max-level 2)
                                 :include (include nil) :exclude (exclude nil))
  "Inserts a table of contents with the titles of the current file.

MIN-LEVEL and MAX-LEVEL can be used to control what kind of titles should appear.
INCLUDE is a list with title tags forcing them to appear in the table of contents (not evaluated).
EXCLUDE is a list with title tags forcing them to not appear in the table of contents (not evaluated).
INCLUDE and EXCLUDE cannot share any tags."
  `(table-of-contents% :min-level ,min-level :max-level ,max-level
                       :include ',include :exclude ',exclude))


(defun file-titles (file)
  "Return the header-type elements of a file."
  (loop for element in (adp:file-elements file)
        for value = (adp:element-value element)
        if (typep value 'title)
          collect value))

(defun make-toc-levels (titles)
  "Return a list of levels for the given titles."
  (loop for title in titles
        for prev-level = (slot-value title 'level) then title-level
        for title-level = (slot-value title 'level)
        for prev-used-level = 0 then next-level
        for next-level = (clamp (+ prev-used-level (- title-level prev-level))
                                0 (1+ prev-used-level))
        collect next-level))

(defun make-toc-list (titles)
  "Makes a list from a bunch of titles."
  (when (null titles)
    (return-from make-toc-list))
  (let* ((levels (make-toc-levels titles)))
    (let ((levels-it levels)
          (titles-it titles))
      (macrolet ((it-get (it) `(car ,it))
                 (it-next (it) `(setf ,it (cdr ,it)))
                 (it-endp (it) `(atom ,it)))
        (labels ((make-toc-list-aux ()
                   (let ((current-level (it-get levels-it)))
                     (apply #'itemize (loop for level = (it-get levels-it)
                                            for title = (it-get titles-it)
                                            while (<= current-level level)
                                            if (< current-level level)
                                              collect (make-toc-list-aux)
                                            else
                                              collect (item (make-instance 'reference
                                                                           :type :title
                                                                           :symbol (slot-value title 'tag)))
                                              and do (it-next levels-it)
                                                     (it-next titles-it)
                                            while (not (it-endp titles-it)))))))
          (make-toc-list-aux))))))

(defun suitable-title (toc title)
  "Test if a TITLE can be placed in TOC."
  (with-slots (min-level max-level include exclude) toc
    (with-slots (level toc tag) title
      (or
       (member tag include)
       (and
        toc
        (not (member tag exclude))
        (or (not min-level)
            (<= min-level level))
        (or (not max-level)
            (>= max-level level)))))))

(defmethod print-element (stream (element table-of-contents))
  (let* ((titles (file-titles (get-current-file)))
         (filtered-titles (remove-if-not (lambda (title) (suitable-title element title)) titles)))
    (print-element stream (make-toc-list filtered-titles))))


;; ------ table of symbols ------
(defun get-file-description-items (file description-type glossary-type tag-type)
  (loop for file-element in (adp:file-elements file)
        for file-value = (adp:element-value file-element)
        if (typep file-value description-type)
          collect (with-slots (tag) file-value
                    (make-instance 'item
                                   :elements (list (make-instance 'reference
                                                                  :type tag-type
                                                                  :symbol tag))))
        if (typep file-value glossary-type)
          append (with-slots (descriptions) file-value
                   (loop for description in descriptions
                         collect (with-slots (tag) description
                                   (make-instance 'item
                                                  :elements (list (make-instance 'reference
                                                                                 :type tag-type
                                                                                 :symbol tag))))))))

(defclass table-of-symbols ()
  ((description-class :initarg :description-class)
   (glossary-class :initarg :glossary-class)
   (tag-type :initarg :tag-type)))

(defun make-reference-itemize (element)
  (with-slots (description-class glossary-class tag-type) element
    (let ((items (get-file-description-items (get-current-file)
                                             description-class glossary-class tag-type)))
      (make-instance 'itemize :items items))))

(defmethod print-element (stream (element table-of-symbols))
  (format stream "~/adpgh:format-element/" (make-reference-itemize element)))

(adp:defun table-of-functions ()
  "Inserts references to function descriptions from the current file."
  (make-instance 'table-of-symbols :description-class 'function-description
                                   :glossary-class 'function-glossary
                                   :tag-type :function))

(adp:defun table-of-variables ()
  "Inserts references to function descriptions from the current file."
  (make-instance 'table-of-symbols :description-class 'variable-description
                                   :glossary-class 'variable-glossary
                                   :tag-type :variable))

(adp:defun table-of-classes ()
  "Inserts references to function descriptions from the current file."
  (make-instance 'table-of-symbols :description-class 'class-description
                                   :glossary-class 'class-glossary
                                   :tag-type :class))
