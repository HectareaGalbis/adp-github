
(in-package #:adpgh)

#@header{Reference}

#@text{
This is the list of functions and macros defined by @inline{ADP-GITHUB}. Almost all these functions can be used in both lisp and text mode. However, the last macros that define things, must only be used in lisp mode.
}

#@subheader{Lisp and text mode functions}

;; ------ aux functions ------
(cl:defun make-unique-tag ()
  (let ((new-tag (gensym "HEADERTAG")))
    (import new-tag "ADP-GITHUB")
    (values new-tag)))

(cl:defun get-keyword-parameter (key params)
  (cond
    ((null params) nil)
    ((eq key (car params)) (cadr params))
    (t (get-keyword-parameter key (cdr params)))))

(cl:defun remove-keyword-parameters (params)
  (and params
       (let ((key (car params)))
         (if (keywordp key)
             (remove-keyword-parameters (cddr params))
             (cons (car params) (remove-keyword-parameters (cdr params)))))))


;; ------ header ------
(cl:defmacro define-header-function (name type)
  (with-gensyms (tag fixed-tag-sym tag-obj header-obj)
    `(adv-defmacro ,name (&rest args)
       `(let* ((,',tag (get-keyword-parameter :tag ',args))
               (,',fixed-tag-sym (or ,',tag (make-unique-tag)))
               (,',tag-obj (make-tag ,',fixed-tag-sym :header))
               (,',header-obj (make-instance ',',type
                                           :elements (remove-keyword-parameters ',args)
                                           :user-tag-p (and ,',tag t)
                                           :tag ,',tag-obj
                                           :target-location (file-target-relative-pathname *process-file*))))
          (setf (get-tag-value ,',tag-obj) ,',header-obj)
          (values ,',header-obj)))))

(define-header-function header header)
(define-header-function subheader subheader)
(define-header-function subsubheader subsubheader)


;; ------ text ------
(adv-defun text (&rest elements)
  (make-instance 'text :elements elements))


;; ------ references ------
(cl:defmacro define-reference-function (name type tag-type)
  `(adv-defmacro ,name (sym)
     `(make-instance ',',type :tag (make-tag ',sym ,',tag-type))))

(define-reference-function href header-reference :header)
(define-reference-function fref function-reference :function)
(define-reference-function vref variable-reference :variable)
(define-reference-function tref type-reference :type)


;; ------ table ------
(adv-defun cell (&rest elements)
  (make-instance 'cell :elements elements))

(adv-defun row (&rest elements)
  (loop for element in elements
        when (not (typep element 'cell))
          do (error "Each element of a row must be a cell."))
  (make-instance 'row :cells elements))

(adv-defun table (&rest elements)
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
(adv-defun item (&rest elements)
  (make-instance 'item :elements elements))

(adv-defun itemize (&rest elements)
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'itemize :items elements))

(adv-defun enumerate (&rest elements)
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'enumerate :items elements))


;; ------ table of contents ------
(adv-defun table-of-contents ()
  (make-instance 'table-of-contents))

(adv-defun mini-table-of-contents ()
  (make-instance 'mini-table-of-contents))

(adv-defun table-of-functions ()
  (make-instance 'table-of-functions))

(adv-defun table-of-symbols ()
  (make-instance 'table-of-symbols))

(adv-defun table-of-types ()
  (make-instance 'table-of-types))


;; ------ image ------
(adv-defun image (path &key (alt-text "Image") (scale 1.0))
  (make-instance 'image
                 :path path
                 :alt-text alt-text
                 :scale scale))


;; ------ text decorators ------
(cl:defmacro define-text-decorator (name type)
  `(adv-defun ,name (&rest elements)
     (make-instance ',type :elements elements)))

(define-text-decorator bold bold)
(define-text-decorator italic italic)
(define-text-decorator emphasis emphasis)
(define-text-decorator inline inline-code)


;; ------ web link ------
(adv-defun link (name address)
  (make-instance 'link :name name :address address))


;; ------ quote ------
(adv-defun quote (&rest elements)
  (make-instance 'quoted :elements elements))


;; ------ code block ------
(adv-defmacro code-block (&rest expressions)
  `(make-instance 'code-block :expressions ',expressions))


;; ------ verbatim code block ------
(adv-defun verbatim-code-block (lang &rest elements)
  (make-instance 'verbatim-code-block :lang lang :elements elements))


;; ------ example ------
(adv-defmacro example (&rest expressions)
  (with-gensyms (output result)
    `(let* ((,output (make-array 10 :adjustable t :fill-pointer 0 :element-type 'character))
	    (,result (multiple-value-list (with-output-to-string (*standard-output* ,output)
					    ,@expressions))))

       (make-instance 'example :expressions ',expressions :output ,output :result ,result))))

#@subheader{Only lisp mode functions}

;; ------ definitions ------
(cl:defmacro define-definition-macro (name type tag-extraction-expr tag-type docstring)
  (let ((body (if tag-extraction-expr
		  (car tag-extraction-expr)
		  (make-symbol "BODY")))
	(tag-extraction (if tag-extraction-expr
			    (cadr tag-extraction-expr)
			    nil))
        (cl-name (find-symbol (symbol-name name) "CL")))
    (with-gensyms (tag obj)
      `(adv-defmacro ,name (&body ,body)
         ,docstring
         `(progn
	    ,@(when adp:*adp*
	        `((let* (,@,(when tag-extraction-expr
                              ``((,',tag (make-tag ',,tag-extraction ,',tag-type))))
                         (,',obj (make-instance ',',type
					        :expression '(,',cl-name ,@,body)
					        ,@,(when tag-extraction-expr
						     ``(:tag ,',tag
                                                        :target-location (file-target-relative-pathname *process-file*))))))
                    (adp:add-element ,',obj)
                    ,@,(when tag-extraction-expr
                         ``((setf (get-tag-value ,',tag) ,',obj))))))
	    (,',cl-name ,@,body))))))

(define-definition-macro defclass defclass-definition (body (car body)) :type
  "Add a defclass declaration. The macro expands to cl:defclass. Also, the class name is used to create a type-tag.")
(define-definition-macro defconstant defconstant-definition (body (car body)) :variable
  "Add a defconstant declaration. The macro expands to cl:defconstant. Also, the constant name is used to create a symbol-tag.")
(define-definition-macro defgeneric defgeneric-definition (body (car body)) :function
  "Add a defgeneric declaration. The macro expands to cl:defgeneric. Also, the generic function name is used to create a function-tag.")
(define-definition-macro define-compiler-macro define-compiler-macro-definition nil nil
  "Add a define-compiler-macro declaration. The macro expands to cl:define-compiler-macro.")
(define-definition-macro define-condition define-condition-definition (body (car body)) :type
  "Add a define-condition declaration. The macro expands to cl:define-condition. Also, the condition name is used to create a type-tag.")
(define-definition-macro define-method-combination define-method-combination-definition nil nil
  "Add a define-method-combination declaration. The macro expands to cl:define-method-combination.")
(define-definition-macro define-modify-macro define-modify-macro-definition (body (car body)) :function
  "Add a define-modify-macro declaration. The macro expands to cl:define-modify-macro. Also, the macro name is used to create a function-tag.")
(define-definition-macro define-setf-expander define-setf-expander-definition nil nil
  "Add a define-setf-expander declaration. The macro expands to cl:define-setf-expander.")
(define-definition-macro define-symbol-macro define-symbol-macro-definition (body (car body)) :variable
  "Add a define-symbol-macro declaration. The macro expands to cl:define-symbol-macro. Also, the symbol name is used to create a symbol-tag.")
(define-definition-macro defmacro defmacro-definition (body (car body)) :function
  "Add a defmacro declaration. The macro expands to cl:defmacro. Also, the macro name is used to create a function-tag.")
(define-definition-macro defmethod defmethod-definition nil nil
  "Add a defmethod declaration. The macro expands to cl:defmethod.")
(define-definition-macro defpackage defpackage-definition nil nil
  "Add a defpackage declaration. The macro expands to cl:defpackage.")
(define-definition-macro defparameter defparameter-definition (body (car body)) :variable
  "Add a defparameter declaration. The macro expands to cl:defparameter. Also, the parameter name is used to create a symbol-tag.")
(define-definition-macro defsetf defsetf-definition nil nil
  "Add a defsetf declaration. The macro expands to cl:defsetf.")
(define-definition-macro defstruct defstruct-definition (body (car body)) :type
  "Add a defstruct declaration. The macro expands to cl:defstruct. Also, the struct name is used to create a type-tag.")
(define-definition-macro deftype deftype-definition (body (car body)) :type
  "Add a deftype declaration. The macro expands to cl:deftype. Also, the type name is used to create a type-tag.")
(define-definition-macro defun defun-definition (body (if (symbolp (car body))
								 (car body)
								 nil))
  :function
  "Add a defun declaration. The macro expands to cl:defun. Also, the function name is used to create a function-tag.")
(define-definition-macro defvar defvar-definition (body (car body)) :variable
  "Add a defvar declaration. The macro expands to cl:defvar. Also, the variable name is used to create a symbol-tag.")
