
(in-package #:adpgh)


;; ------ aux functions ------
(defun make-unique-tag ()
  (let ((new-tag (gensym "HEADERTAG")))
    (import new-tag "ADP-GITHUB")
    (values new-tag)))

(defun get-keyword-parameter (key params)
  (cond
    ((null params) nil)
    ((eq key (car params)) (cadr params))
    (t (get-keyword-parameter key (cdr params)))))

(defun remove-keyword-parameters (params)
  (and params
       (let ((key (car params)))
         (if (keywordp key)
             (remove-keyword-parameters (cddr params))
             (cons (car params) (remove-keyword-parameters (cdr params)))))))

(defmacro with-key-params ((key-args rest-args args) &body body)
  (once-only (args)
    (let* ((keyword-args (mapcar (lambda (key-arg)
                                   (intern (symbol-name key-arg) "KEYWORD"))
                                 key-args))
           (let-args (mapcar (lambda (key-arg keyword-arg)
                               `(,key-arg (get-keyword-parameter ,keyword-arg ,args)))
                             key-args keyword-args)))
      `(let (,@let-args
             (,rest-args (remove-keyword-parameters ,args)))
         ,@body))))


;; ------ header ------
(defmacro define-header-function (name type)
  (with-gensyms (tag fixed-tag-sym tag-obj header-obj)
    `(defmacro ,name (&rest args)
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
(defun text (&rest elements)
  (make-instance 'text :elements elements))


;; ------ references ------
(defmacro define-reference-function (name type tag-type)
  `(defmacro ,name (sym)
     `(make-instance ',',type :tag (make-tag ',sym ,',tag-type))))

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
  (make-instance 'itemize :items elements))

(defun enumerate (&rest elements)
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'enumerate :items elements))


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
(define-text-decorator code inline-code)


;; ------ web link ------
(defun link (&rest elements)
  (with-key-params ((address) rest-elements elements)
    (make-instance 'link :elements rest-elements :address address)))


;; ------ quote ------
(defun quoted (&rest elements)
  (make-instance 'quoted :elements elements))


;; ------ code block ------
(defmacro code-block (&rest expressions)
  `(make-instance 'code-of-block :expressions ',expressions))


;; ------ verbatim code block ------
(defun verbatim-code-block (&rest elements)
  (with-key-params ((lang) rest-elements elements)
    (make-instance 'verbatim-code-of-block :lang lang :elements rest-elements)))


;; ------ example ------
(defmacro example (&rest expressions)
  (with-gensyms (output result)
    `(let* ((,output (make-array 10 :adjustable t :fill-pointer 0 :element-type 'character))
	    (,result (multiple-value-list (with-output-to-string (*standard-output* ,output)
					    ,@expressions))))

       (make-instance 'example :expressions ',expressions :output ,output :results ,result))))


;; ------ function descriptions ------
(defmacro function-description (sym)
  (with-gensyms (tag instance)
    `(let ((,tag (make-tag ',sym :function))
           (,instance (make-instance 'function-description :symbol ',sym
                                                           :target-location (file-target-relative-pathname *process-file*))))
       (when (not (get-tag-value ,tag))
         (setf (get-tag-value ,tag) ,instance))
       (values ,instance))))


;; ------ variable description ------
(defmacro variable-description (sym)
  (with-gensyms (tag instance)
    `(let ((,tag (make-tag ',sym :variable))
           (,instance (make-instance 'variable-description :symbol ',sym
                                                           :target-location (file-target-relative-pathname *process-file*))))
       (when (not (get-tag-value ,tag))
         (setf (get-tag-value ,tag) ,instance))
       (values ,instance))))


;; ------ class description ------
(defmacro class-description (sym)
  (with-gensyms (tag instance)
    `(let ((,tag (make-tag ',sym :class))
           (,instance (make-instance 'class-description :symbol ',sym
                                                        :target-location (file-target-relative-pathname *process-file*))))
       (when (not (get-tag-value ,tag))
         (setf (get-tag-value ,tag) ,instance))
       (values ,instance))))


;; ------ package description ------
(defmacro package-description (pkg)
  (with-gensyms (actual-pkg tag instance)
    `(let* ((,actual-pkg (find-package ',pkg))
            (,tag (make-tag (intern (package-name ,actual-pkg) "KEYWORD") :package))
            (,instance (make-instance 'package-description :package ,actual-pkg
                                                           :target-location (file-target-relative-pathname *process-file*))))
       (when (not (get-tag-value ,tag))
         (setf (get-tag-value ,tag) ,instance))
       (values ,instance))))


;; ------ system description ------
(defmacro system-description (system-name)
  (with-gensyms (system tag instance)
    `(let* ((,system (asdf:find-system ',system-name))
            (,tag (make-tag (intern (asdf:component-name ,system) "KEYWORD") :system))
            (,instance (make-instance 'system-description :system ,system
                                                          :target-location (file-target-relative-pathname *process-file*))))
       (when (not (get-tag-value ,tag))
         (setf (get-tag-value ,tag) ,instance))
       (values ,instance))))


;; ------ glossary ------
(defmacro function-glossary (pkg)
  (with-gensyms (fdescriptions sym tag instance)
    `(let ((,fdescriptions '()))
       (do-external-symbols (,sym (find-package ',pkg))
         (when (fboundp ,sym)
           (let ((,tag (make-tag ,sym :function))
                 (,instance (make-instance 'function-description :symbol ,sym
                                                                 :target-location (file-target-relative-pathname *process-file*))))
             (push ,instance ,fdescriptions)
             (setf (get-tag-value ,tag) ,instance))))
       (make-instance 'function-glossary :descriptions ,fdescriptions))))

(defmacro variable-glossary (pkg)
  (with-gensyms (vdescriptions sym tag instance)
    `(let ((,vdescriptions '()))
       (do-external-symbols (,sym (find-package ',pkg))
         (when (boundp ,sym)
           (let ((,tag (make-tag ,sym :variable))
                 (,instance (make-instance 'variable-description :symbol ,sym
                                                                 :target-location (file-target-relative-pathname *process-file*))))
             (push ,instance ,vdescriptions)
             (setf (get-tag-value ,tag) ,instance))))
       (make-instance 'variable-glossary :descriptions ,vdescriptions))))

(defmacro class-glossary (pkg)
  (with-gensyms (cdescriptions sym tag instance)
    `(let ((,cdescriptions '()))
       (do-external-symbols (,sym (find-package ',pkg))
         (when (find-class ,sym)
           (let ((,tag (make-tag ,sym :class))
                 (,instance (make-instance 'class-description :symbol ,sym
                                                              :target-location (file-target-relative-pathname *process-file*))))
             (push ,instance ,cdescriptions)
             (setf (get-tag-value ,tag) ,instance))))
       (make-instance 'variable-glossary :descriptions ,cdescriptions))))





;; (defmacro define-definition-macro (name type tag-extraction-expr tag-type docstring)
;;   (let ((body (if tag-extraction-expr
;; 		  (car tag-extraction-expr)
;; 		  (make-symbol "BODY")))
;; 	(tag-extraction (if tag-extraction-expr
;; 			    (cadr tag-extraction-expr)
;; 			    nil))
;;         (cl-name (find-symbol (symbol-name name) "CL")))
;;     (with-gensyms (tag obj)
;;       `(defmacro ,name (&body ,body)
;;          ,docstring
;;          `(progn
;; 	    ,@(when adp:*adp*
;; 	        `((let* (,@,(when tag-extraction-expr
;;                               ``((,',tag (make-tag ',,tag-extraction ,',tag-type))))
;;                          (,',obj (make-instance ',',type
;; 					        :expression '(,',cl-name ,@,body)
;; 					        ,@,(when tag-extraction-expr
;; 						     ``(:tag ,',tag
;;                                                         :target-location (file-target-relative-pathname *process-file*))))))
;;                     (adp:add-element ,',obj)
;;                     ,@,(when tag-extraction-expr
;;                          ``((setf (get-tag-value ,',tag) ,',obj))))))
;; 	    (,',cl-name ,@,body))))))

;; (define-definition-macro defclass defclass-definition (body (car body)) :type
;;   "Add a defclass declaration. The macro expands to defclass. Also, the class name is used to create a type-tag.")
;; (define-definition-macro defconstant defconstant-definition (body (car body)) :variable
;;   "Add a defconstant declaration. The macro expands to defconstant. Also, the constant name is used to create a symbol-tag.")
;; (define-definition-macro defgeneric defgeneric-definition (body (car body)) :function
;;   "Add a defgeneric declaration. The macro expands to defgeneric. Also, the generic function name is used to create a function-tag.")
;; (define-definition-macro define-compiler-macro define-compiler-macro-definition nil nil
;;   "Add a define-compiler-macro declaration. The macro expands to define-compiler-macro.")
;; (define-definition-macro define-condition define-condition-definition (body (car body)) :type
;;   "Add a define-condition declaration. The macro expands to define-condition. Also, the condition name is used to create a type-tag.")
;; (define-definition-macro define-method-combination define-method-combination-definition nil nil
;;   "Add a define-method-combination declaration. The macro expands to define-method-combination.")
;; (define-definition-macro define-modify-macro define-modify-macro-definition (body (car body)) :function
;;   "Add a define-modify-macro declaration. The macro expands to define-modify-macro. Also, the macro name is used to create a function-tag.")
;; (define-definition-macro define-setf-expander define-setf-expander-definition nil nil
;;   "Add a define-setf-expander declaration. The macro expands to define-setf-expander.")
;; (define-definition-macro define-symbol-macro define-symbol-macro-definition (body (car body)) :variable
;;   "Add a define-symbol-macro declaration. The macro expands to define-symbol-macro. Also, the symbol name is used to create a symbol-tag.")
;; (define-definition-macro defmacro defmacro-definition (body (car body)) :function
;;   "Add a defmacro declaration. The macro expands to defmacro. Also, the macro name is used to create a function-tag.")
;; (define-definition-macro defmethod defmethod-definition nil nil
;;   "Add a defmethod declaration. The macro expands to defmethod.")
;; (define-definition-macro defpackage defpackage-definition nil nil
;;   "Add a defpackage declaration. The macro expands to defpackage.")
;; (define-definition-macro defparameter defparameter-definition (body (car body)) :variable
;;   "Add a defparameter declaration. The macro expands to defparameter. Also, the parameter name is used to create a symbol-tag.")
;; (define-definition-macro defsetf defsetf-definition nil nil
;;   "Add a defsetf declaration. The macro expands to defsetf.")
;; (define-definition-macro defstruct defstruct-definition (body (car body)) :type
;;   "Add a defstruct declaration. The macro expands to defstruct. Also, the struct name is used to create a type-tag.")
;; (define-definition-macro deftype deftype-definition (body (car body)) :type
;;   "Add a deftype declaration. The macro expands to deftype. Also, the type name is used to create a type-tag.")
;; (define-definition-macro defun defun-definition (body (if (symbolp (car body))
;; 								 (car body)
;; 								 nil))
;;   :function
;;   "Add a defun declaration. The macro expands to defun. Also, the function name is used to create a function-tag.")
;; (define-definition-macro defvar defvar-definition (body (car body)) :variable
;;   "Add a defvar declaration. The macro expands to defvar. Also, the variable name is used to create a symbol-tag.")
