
(in-package #:adp-github)


;; ------ table-of-contents ------
(defclass table-of-contents ()
  ((min-level :initarg :min-level)
   (max-level :initarg :max-level)
   (include :initarg :include)
   (exclude :initarg :exclude))
  (:documentation
   "Represents a table of contents."))

(adp:defun table-of-contents (:min-level (min-level 0) :max-level (max-level 2)
                              :include (include nil) :exclude (exclude nil))
  "Inserts a table of contents with the titles of the current file."
  (check-type min-level number)
  (check-type max-level number)
  (let ((problematic-tags (intersection include exclude)))
    (when problematic-tags
      (error "Error: The following tags were found in both include and exclude lists: ~s"
             problematic-tags)))
  (make-instance 'table-of-contents :min-level min-level :max-level max-level
                                    :include include :exclude exclude))


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
                                            do (it-next levels-it)
                                               (it-next titles-it)
                                            while (not (it-endp titles-it)))))))
          (make-toc-list-aux))))))

(defun suitable-title (toc title)
  "Test if a TITLE can be placed in TOC."
  (with-slots (min-level max-level include exclude) toc
    (with-slots (level toc tag) title
      (and
       (not (member tag exclude))
       (or (member tag include)
           toc)
       (or (not min-level)
           (<= min-level level))
       (or (not max-level)
           (>= max-level level))))))

(defmethod print-element (stream (element table-of-contents))
  (let* ((titles (file-titles (get-current-file)))
         (filtered-titles (remove-if-not (lambda (title) (suitable-title element title)) titles)))
    (print-element stream (make-toc-list filtered-titles))))


;; ------ table of symbols ------
(defun get-file-description-items (file description-type tag-type)
  (loop for file-element in (adp:file-elements file)
        if (typep file-element description-type)
          collect (with-slots (tag) file-element
                    (make-instance 'item
                                   :items (list (make-instance 'reference :type tag-type :symbol tag))))))

(defclass table-of-symbols ()
  ((reference-itemize :initform nil :allocation :class)
   (description-class :initarg :description-class)
   (tag-type :initarg :tag-type)))

(defmethod process-element ((element table-of-symbols))
  (with-slots (reference-itemize description-class tag-type) element
    (when (not reference-itemize)
      (let ((items (get-file-function-items (get-current-file) description-class tag-type)))
        (setf reference-itemize (make-instance 'itemize :items items))))))

(defmethod print-element (stream (element table-of-symbols))
  (format stream "~/print-element/" (slot-value element 'reference-itemize)))


(defclass table-of-functions ()
  ((reference-itemize :initform nil :allocation :class)))

(adp:defun table-of-functions ()
  "Inserts references to function descriptions from the current file."
  (make-instance 'table-of-symbols :description-class 'function-description :tag-type :function))

(defclass table-of-variables ()
  ((reference-itemize :initform nil :allocation :class)))

(adp:defun table-of-variables ()
  "Inserts references to function descriptions from the current file."
  (make-instance 'table-of-symbols :description-class 'variable-description :tag-type :variable))

(defclass table-of-classes ()
  ((reference-itemize :initform nil :allocation :class)))

(adp:defun table-of-classes ()
  "Inserts references to function descriptions from the current file."
  (make-instance 'table-of-symbols :description-class 'class-description :tag-type :class))
