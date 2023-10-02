
(in-package #:adp-gh)



(defmacro define-adp-function (name args &body body)
  (check-type name symbol)
  (check-type args list)
  (let ((adp-name (intern (symbol-name name) "ADP-USER"))
        (args-sym (gensym "ARGS")))
    `(progn
       (defun ,adp-name ,args
         ,@body)
       (defmacro ,name (&rest ,args-sym)
         (when adp:*adp*
           `(adp:add-element (,',adp-name ,@,args-sym)))))))


(defun remove-keyword-parameters (params)
  (and params
       (let ((key (car params)))
         (if (keywordp key)
             (remove-keyword-parameters (cddr params))
             (cons (car params) (remove-keyword-parameters (cdr params)))))))


;; ------ header ------
(defmacro define-header-function (name type)
  (with-gensyms (args tag fixed-tag-sym tag-obj header-obj)
    `(define-adp-function ,name (&rest args &key tag)
       (let* ((fixed-tag-sym (or tag (make-unique-tag)))
              (tag-obj (make-tag :symbol fixed-tag-sym :type :header))
              (header-obj (make-instance ',type
                                         :elements (remove-keyword-parameters args)
                                         :user-tag-p (and tag t)
                                         :tag tag-obj
                                         :target-location *current-target-pathname*)))
         (setf (get-tag-value tag-obj) header-obj)
         (values header-obj)))))

(define-header-function header header)
(define-header-function subheader subheader)
(define-header-function subsubheader subsubheader)


;; ------ text ------
(adv-defmacro text (&rest objects)
  "Add plain text. The arguments in objects can be any lisp object. They will be princ-ed and concatenated into a single string.
You can use the following macros to enrich your text: bold, italic, emphasis, inline-code, web-link, header-ref, symbol-ref, function-ref and type-ref."
  (when *adp*
    (let ((eval-objects (gensym "OBJECTS"))
          (eval-object (gensym "OBJECT")))
      `(progn
         (destructuring-bind (&rest ,eval-objects) `(list ,@objects)
           (loop for ,eval-object in ,eval-objects
                 do (adp:add-element ,eval-object)))
         (values)))))


;; ------ table ------
(define-adp-function cell (&rest elements)
  (make-instance 'cell :elements elements))

(define-adp-function row (&rest elements)
  (loop for element in elements
        when (not (typep element 'cell))
          do (error "Each element of a row must be a cell."))
  (make-instance 'row :cells elements))

(define-adp-function table (&rest elements)
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
(define-adp-function item (&rest elements)
  (make-instance 'item :elements elements))

(define-adp-function itemize (&rest elements)
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'itemize :elements elements))

(define-adp-function enumerate (&rest elements)
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'enumerate :elements elements))


;; ------ table of contents ------
(define-adp-function table-of-contents ()
  (make-instance 'table-of-contents))

(define-adp-function mini-table-of-contents ()
  (make-instance 'mini-table-of-contents))

(define-adp-function table-of-functions ()
  (make-instance 'table-of-functions))

(define-adp-function table-of-symbols ()
  (make-instance 'table-of-symbols))

(define-adp-function table-of-types ()
  (make-instance 'table-of-types))


;; ------ image ------
(define-adp-function image (path &key (alt-text "Image") (scale 1.0))
  (make-instance 'image
                 :path path
                 :alt-text alt-text
                 :scale scale))


;; ------ text decorators ------
(defmacro define-text-decorator (name type)
  (with-gensyms (elements)
    `(define-adp-function ,name (&rest ,elements)
       (make-instance ',type :elements ,elements))))

(define-text-decorator bold bold)
(define-text-decorator italic italic)
(define-text-decorator emphasis emphasis)
(define-text-decorator inline inline)


;; ------ web link ------
(define-adp-function link (name address)
  (make-instance 'link :name name :address address))


;; ------ references ------
(defmacro define-reference-function (name type tag-type)
  (with-gensyms (symbol)
    `(define-adp-function ,name (,symbol)
       (make-instance ',type :tag (make-tag :symbol ,symbol :type ,tag-type)))))

(define-reference-function href header-reference :header)
(define-reference-function fref function-reference :function)
(define-reference-function vref variable-reference :variable)
(define-reference-function tref type-reference :type)


;; ------ quote ------
(define-adp-function quote (&rest elements)
  (make-instance 'quote :elements elements))


;; ------ code block ------
(define-adp-function code-block (&rest expressions)
  (make-instance 'code-block :expressions expressions))


;; ------ verbatim code block ------
(define-adp-function verbatim-code-block (&rest elements)
  (make-instance 'verbatim-code-block :elements elements))


;; ------ example ------
(define-adp-function example (&rest expressions)
  (make-instance 'example :expressions expressions))
