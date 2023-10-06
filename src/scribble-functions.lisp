
(in-package #:adpgh-scribble)


;; ------ aux functions ------
(defun make-unique-tag ()
  (let ((new-tag (gensym "HEADERTAG")))
    (import new-tag "ADPGH-SCRIBBLE")
    (values new-tag)))

(defun remove-keyword-parameters (params)
  (and params
       (let ((key (car params)))
         (if (keywordp key)
             (remove-keyword-parameters (cddr params))
             (cons (car params) (remove-keyword-parameters (cdr params)))))))


;; ------ header ------
(defmacro define-header-function (name type)
  (with-gensyms (fixed-tag-sym tag-obj header-obj)
    `(defun ,name (&rest args &key tag)
       (let* ((,fixed-tag-sym (or tag (make-unique-tag)))
              (,tag-obj (adpgh-core:make-tag fixed-tag-sym :header))
              (,header-obj (make-instance ',type
                                         :elements (remove-keyword-parameters args)
                                         :user-tag-p (and tag t)
                                         :tag ,tag-obj
                                         :target-location (adp-core:file-target-relative-pathname adp:*load-file*))))
         (setf (adp-core:get-tag-value ,tag-obj) header-obj)
         (values ,header-obj)))))

(define-header-function header header)
(define-header-function subheader subheader)
(define-header-function subsubheader subsubheader)


;; ------ references ------
(defmacro define-reference-function (name type tag-type)
  `(defmacro ,name (sym)
     `(make-instance ',',type :tag (make-tag :symbol ',sym :type ,,tag-type))))

(define-reference-function href header-reference :header)
(define-reference-function fref function-reference :function)
(define-reference-function vref variable-reference :variable)
(define-reference-function tref type-reference :type)


;; ------ table ------
(defun cell (&rest elements)
  (make-instance 'cell :elements elements))

(defun row (&rest elements)
  (loop for element in elements
        when (not (typep element 'cell))
          do (error "Each element of a row must be a cell."))
  (make-instance 'row :cells elements))

(defun table (&rest elements)
  (assert (> (length elements) 0))
  (let ((num-cells (length (row-cells (car elements)))))
    (loop for element in elements
          for row-num-cells = (length (row-cells element))
          when (not (eql num-cells row-num-cells))
            do (error "Every row must have the same number of elements.")
          when (not (typep element 'row))
            do (error "Each element of a table must be a row.")))
  (make-instance 'table :rows elements))


;; ------ itemize ------
(defun item (&rest elements)
  (make-instance 'item :elements elements))

(defun itemize (&rest elements)
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'itemize :elements elements))

(defun enumerate (&rest elements)
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'enumerate :elements elements))


;; ------ table of contents ------
(defun table-of-contents ()
  (make-instance 'table-of-contents))

(defun mini-table-of-contents ()
  (make-instance 'mini-table-of-contents))

(defun table-of-functions ()
  (make-instance 'table-of-functions))

(defun table-of-symbols ()
  (make-instance 'table-of-symbols))

(defun table-of-types ()
  (make-instance 'table-of-types))


;; ------ image ------
(defun image (path &key (alt-text "Image") (scale 1.0))
  (make-instance 'image
                 :path path
                 :alt-text alt-text
                 :scale scale))


;; ------ text decorators ------
(defmacro define-text-decorator (name type)
  `(defun ,name (&rest elements)
     (make-instance ',type :elements elements)))

(define-text-decorator bold bold)
(define-text-decorator italic italic)
(define-text-decorator emphasis emphasis)
(define-text-decorator inline inline)


;; ------ web link ------
(defun link (name address)
  (make-instance 'link :name name :address address))


;; ------ quote ------
(defun quote (&rest elements)
  (make-instance 'quote :elements elements))


;; ------ code block ------
(defmacro code-block (&rest expressions)
  `(make-instance 'code-block :expressions ',expressions))


;; ------ verbatim code block ------
(defun verbatim-code-block (&rest elements)
  (make-instance 'verbatim-code-block :elements elements))


;; ------ example ------
(defmacro example (&rest expressions)
  `(make-instance 'example :expressions ',expressions))
