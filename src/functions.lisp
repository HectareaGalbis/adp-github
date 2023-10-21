
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
  (let ((docstring (format nil "Inserts a ~a. Also, a keyword :tag can be supplied to be used as a header tag."
			   (string-downcase (symbol-name name)))))
    (with-gensyms (tag fixed-tag-sym tag-obj header-obj)
      `(defmacro ,name (&rest args)
         ,docstring
         `(let* ((,',tag (get-keyword-parameter :tag ',args))
                 (,',fixed-tag-sym (or ,',tag (make-unique-tag)))
                 (,',tag-obj (make-tag ,',fixed-tag-sym :header))
                 (,',header-obj (make-instance ',',type
                                               :elements (remove-keyword-parameters ',args)
                                               :user-tag-p (and ,',tag t)
                                               :tag ,',tag-obj
                                               :target-location (file-target-relative-pathname *process-file*))))
            (setf (get-tag-value ,',tag-obj) ,',header-obj)
            (values ,',header-obj))))))

(define-header-function header header)
(define-header-function subheader subheader)
(define-header-function subsubheader subsubheader)


;; ------ text ------
(defun text (&rest elements)
  "Intended for using in lisp mode files or define custom functions. Just inserts every argument."
  (make-instance 'text :elements elements))


;; ------ references ------
(defmacro href (&rest elements)
  "Inserts a header reference. I. e. a hyperlink to a header."
  (with-key-params ((tag) rest-args elements)
    `(make-instance 'header-reference :tag (make-tag ',tag :header) :text-elements ',rest-args)))

(defmacro define-reference-function (name type tag-type)
  (let* ((ref-type (string-downcase (symbol-name tag-type)))
         (docstring (format nil "Inserts a ~a reference. I. e. a hyperlink to a ~a description."
                            ref-type ref-type)))
    `(defmacro ,name (sym)
       ,docstring
       `(make-instance ',',type :tag (make-tag ',sym ,',tag-type)))))

(define-reference-function fref function-reference :function)
(define-reference-function vref variable-reference :variable)
(define-reference-function cref type-reference :class)

(defmacro pref (pkg)
  "Inserts a package reference. I. e. a hyperlink to a package description."
  (with-gensyms (actual-pkg tag)
    `(let* ((,actual-pkg (find-package ',pkg))
            (,tag (make-tag (intern (package-name ,actual-pkg) "KEYWORD") :package)))
       (make-instance 'package-reference :tag ,tag))))

(defmacro sref (system-name)
  "Inserts a system reference. I. e. a hyperlink to a system description."
  (with-gensyms (system tag)
    `(let* ((,system (asdf:find-system ',system-name))
            (,tag (make-tag (intern (asdf:component-name ,system) "KEYWORD") :system)))
       (make-instance 'system-reference :tag ,tag))))


;; ------ table ------
(defun cell (&rest elements)
  "The cells are the components of a row. All the elements will be inserted inside a cell table."
  (make-instance 'cell :elements elements))

(defun row (&rest elements)
  "The rows are the components of a table. The elements must be cells."
  (loop for element in elements
        when (not (typep element 'cell))
          do (error "Each element of a row must be a cell."))
  (make-instance 'row :cells elements))

(defun table (&rest elements)
  "Inserts a table. The elements must be rows."
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
  "Inserts an element if it is used inside an itemize or enumerate."
  (make-instance 'item :elements elements))

(defun itemize (&rest elements)
  "Inserts a list. It can contains items or sublists. The elements must be items, itemizes or enumerates."
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'itemize :items elements))

(defun enumerate (&rest elements)
  "Inserts a enumerated lists. It can contain items or sublist. The elements must be items, itemizes or enumerates."
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be an item."))
  (make-instance 'enumerate :items elements))


;; ------ table of contents ------
(defun table-of-contents ()
  "Inserts a table of contents with the headers and subheaders of every generated file."
  (make-instance 'table-of-contents))

(defun mini-table-of-contents ()
  "Inserts a table of contents with the headers, subheaders and subsubheaders of the current file."
  (make-instance 'mini-table-of-contents))

(defun table-of-functions ()
  "Inserts a table of function. It is a list with references to all the functions that has a description
inserted somewhere."
  (make-instance 'table-of-functions))

(defun table-of-variables ()
  "Inserts a table of variables. It is a list with references to all the variables that has a description
inserted somewhere."
  (make-instance 'table-of-variables))

(defun table-of-classes ()
  "Inserts a table of classes. It is a list with references to all the classes that has a description
inserted somewhere."
  (make-instance 'table-of-classes))


;; ------ image ------
(defun image (path &key (alt-text "Image") (scale 1.0))
  "Inserts an image. It must receive the path to the image (relative to the project's root directory).
Optionally, it can receive an alternative text description and the scale size of the image."
  (make-instance 'image
                 :path path
                 :alt-text alt-text
                 :scale scale))


;; ------ text decorators ------
(defmacro define-text-decorator (name type)
  (let* ((type-name (string-downcase (symbol-name name)))
         (docstring (format nil "Inserts text with ~a style."
                            type-name)))
    `(defun ,name (&rest elements)
       ,docstring
       (make-instance ',type :elements elements))))

(define-text-decorator bold bold)
(define-text-decorator italic italic)
(define-text-decorator emphasis emphasis)
(define-text-decorator code inline-code)


;; ------ web link ------
(defun link (&rest elements)
  "Inserts a link. It must receive the keyword :address. The rest of the elements will form the name of the
link."
  (with-key-params ((address) rest-elements elements)
    (make-instance 'link :elements rest-elements :address address)))


;; ------ quote ------
(defun quoted (&rest elements)
  "Inserts quoted text."
  (make-instance 'quoted :elements elements))


;; ------ code block ------
(defun code-block (&rest elements)
  "Inserts a code of block. It can receive the keyword :lang, a string that specifies the language to be used.
The rest of elements will be inserted inside a block of code."
  (with-key-params ((lang) rest-elements elements)
    (make-instance 'code-of-block :lang lang :elements rest-elements)))


;; ------ example ------
(defmacro example (&rest expressions)
  "Inserts an example. It is like code-block, but evaluates the code (common lisp only) and prints its output
and returned values."
  (let* ((text-code (apply #'concatenate 'string (mapcar #'princ expressions)))
         (code (with-input-from-string (text-stream text-code)
                 (loop for expr = (read text-stream nil nil)
                       while expr
                       collect expr))))
    (with-gensyms (output result)
      `(let* ((,output (make-array 10 :adjustable t :fill-pointer 0 :element-type 'character))
	      (,result (multiple-value-list (with-output-to-string (*standard-output* ,output)
					      ,@code))))
         (make-instance 'example :code ,text-code :output ,output :results ,result)))))


;; ------ function descriptions ------
(defmacro function-description (sym)
  "Inserts a function description. It must receive the function name (a symbol) that represents the function. 
A function description also creates a function tag that can be used with fref."
  (with-gensyms (tag instance)
    `(let ((,tag (make-tag ',sym :function))
           (,instance (make-instance 'function-description :symbol ',sym
                                                           :target-location (file-target-relative-pathname *process-file*))))
       (when (not (get-tag-value ,tag))
         (setf (get-tag-value ,tag) ,instance))
       (values ,instance))))


;; ------ variable description ------
(defmacro variable-description (sym)
  "Inserts a variable description. It must receive the variable name (a symbol) that represents the variable. 
A variable description also creates a variable tag that can be used with vref."
  (with-gensyms (tag instance)
    `(let ((,tag (make-tag ',sym :variable))
           (,instance (make-instance 'variable-description :symbol ',sym
                                                           :target-location (file-target-relative-pathname *process-file*))))
       (when (not (get-tag-value ,tag))
         (setf (get-tag-value ,tag) ,instance))
       (values ,instance))))


;; ------ class description ------
(defmacro class-description (sym)
  "Inserts a class description. It must receive the class name (a symbol) that represents the class. 
A class description also creates a class tag that can be used with cref."
  (with-gensyms (tag instance)
    `(let ((,tag (make-tag ',sym :class))
           (,instance (make-instance 'class-description :symbol ',sym
                                                        :target-location (file-target-relative-pathname *process-file*))))
       (when (not (get-tag-value ,tag))
         (setf (get-tag-value ,tag) ,instance))
       (values ,instance))))


;; ------ package description ------
(defmacro package-description (pkg)
  "Inserts a package description. It must receive a package descriptor that represents the package. 
A package description also creates a package tag that can be used with pref."
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
  "Inserts a system description. It must receive a system description that represents the system. 
A system description also creates a system tag that can be used with sref."
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
  "Inserts a function glossary. It will insert all the available function descriptions. They are gathered from
the external symbols of a given package. The argument pkg must be a package descriptor."
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
  "Inserts a variable glossary. It will insert all the available variable descriptions. They are gathered from
the external symbols of a given package. The argument pkg must be a package descriptor."
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
  "Inserts a class glossary. It will insert all the available class descriptions. They are gathered from
the external symbols of a given package. The argument pkg must be a package descriptor."
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
