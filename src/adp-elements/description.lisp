
(in-package #:adp-github)


(defclass description (located-element)
  ((object :initarg :object)
   (tag :initarg :tag)))


;; --------------------------------------------------------------------------------
(defclass function-description (description) ())

(defun function-description% (name tag)
  (make-instance 'function-description :object name :tag tag))

(adp:defmacro function-description (name :tag (tag (make-unique-tag)))
  "Inserts a function description. It must receive the function name (a symbol) that represents the function. 
A function description also creates a function tag that can be used with fref."
  `(function-description% ',name ',tag))

(defmethod process-element ((element function-description))
  (with-slots ((name object) tag) element
    ;; Index and user tag  
    (setf (get-tags-value :function tag) element)
    ;; fref tag
    (when (not (nth-value 1 (get-tags-value :function name)))
      (setf (get-tags-value :function name) element))))

(defun function-description-anchor (name tag stream)
  (format stream "<a id=~s></a>" (tag-to-string :function name))
  (terpri)
  (format stream "<a id=~s></a>" (tag-to-string :function tag)))

(defun function-description-arguments (name stream)
  (let ((arguments (arg:arglist name)))
    (when (not (eq arguments :unknown))
      (if (null arguments)
          (princ " ()" stream)
          (let ((*print-right-margin* 999)
                (*print-pprint-dispatch* *argument-pprint-dispatch*))
            (format stream " ~s" arguments))))))

(defun macro-description-title (name stream)
  (format stream "#### Macro: ~a" name)
  (function-description-arguments name stream))

(defun function-description-title (name stream)
  (format stream "#### Function: ~a" name)
  (function-description-arguments name stream))

(defun generic-description-title (name stream)
  (format stream "#### Generic function: ~a ~s"
          name (c2mop:generic-function-lambda-list (symbol-function name))))

(defun function-description-docstring (name stream)
  (let* ((docstring (documentation name 'function))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'text :style :italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-element-md/" docstring-block)))

(defmethod print-element (stream (element function-description))
  (with-slots ((name object) tag) element
    (function-description-anchor name tag stream)
    (terpri stream)
    (cond
      ((macro-function name)
       (macro-description-title name stream))
      ((typep (symbol-function name) 'generic-function)
       (generic-description-title name stream))
      ((symbol-function name)
       (function-description-title name stream)))
    (terpri stream)
    (terpri stream)
    (function-description-docstring name stream)))


;; --------------------------------------------------------------------------------
(defclass variable-description (description) ())

(defun variable-description% (name tag)
  "Inserts a variable description. It must receive the variable name (a symbol) that represents the variable. 
A variable description also creates a variable tag that can be used with vref."
  (make-instance 'variable-description :object name :tag tag))

(adp:defmacro variable-description (name :tag (tag (make-unique-tag)))
  "Inserts a variable description. It must receive the variable name (a symbol) that represents the variable. 
A variable description also creates a variable tag that can be used with vref."
  `(variable-description ',name ',tag))

(defmethod process-element ((element variable-description))
  (with-slots ((name object) tag) element
    ;; Index and user tag
    (setf (get-tags-value :variable tag) element)
    ;; vref tag
    (when (not (nth-value 1 (get-tags-value :variable name)))
      (setf (get-tags-value :variable name) element))))

(defun variable-description-anchor (name tag stream)
  (format stream "<a id=~s></a>" (tag-to-string :variable name))
  (terpri)
  (format stream "<a id=~s></a>" (tag-to-string :variable tag)))

(defun variable-description-title (name stream)
  (let ((title (if (constantp name) "Constant" "Variable")))
    (format stream "#### ~a: ~/adpgh:format-element-md/" title (prin1-to-string name))))

(defun variable-description-docstring (name stream)
  (let* ((docstring (documentation name 'variable))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-element-md/" docstring-block)))

(defmethod print-element (stream (element variable-description))
  (with-slots ((name object) tag) element
    (variable-description-anchor name tag stream)
    (terpri stream)
    (variable-description-title name stream)
    (terpri stream)
    (terpri stream)
    (variable-description-docstring name stream)))

;; --------------------------------------------------------------------------------
(defclass class-description (description) ())

(defun class-description% (sym tag)
  (make-instance 'class-description :object sym :tag tag))

(adp:defmacro class-description (sym :tag (tag (make-unique-tag)))
  "Inserts a class description. It must receive the class name (a symbol) that represents the class. 
A class description also creates a class tag that can be used with cref."
  `(class-description% ',sym ',tag))

(defmethod process-element ((element class-description))
  (with-slots ((name object) tag) element
    ;; Index and user tag
    (setf (get-tags-value :class tag) element)
    ;; cref tag
    (when (not (nth-value 1 (get-tags-value :class name)))
      (setf (get-tags-value :class name) element))))

(defun class-description-anchor (name tag stream)
  (format stream "<a id=~s></a>" (tag-to-string :class name))
  (terpri)
  (format stream "<a id=~s></a>" (tag-to-string :class tag)))

(defun class-description-title (class stream)
  (format stream "#### Class: ~a" (class-name class)))

(defun class-description-docstring (class stream)
  (let* ((docstring (documentation class 'type))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-element-md/" docstring-block)))

(defun class-description-metaclass (class stream)
  (format stream "* Metaclass: ~a" (class-name (type-of class))))

(defun class-description-precedence-list (class stream)
  (format stream "* Precedence list: ~{~s~^, ~}" (c2mop:class-precedence-list class)))

(defun class-description-direct-superclasses (class stream)
  (format stream "* Direct superclasses: ~{~s~^, ~}" (c2mop:class-direct-superclasses class)))

(defun class-description-direct-subclasses (class stream)
  (format stream "* Direct subclasses: ~{~s~^, ~}" (c2mop:class-direct-subclasses class)))

(defun slot-name-item (slot-definition)
  (make-instance 'item :elements (list (format nil "~a :" (c2mop:slot-definition-name slot-definition)))))

(defun slot-allocation-item (slot-definition)
  (make-instance 'item :elements (list (format nil "Allocation: ~a"
                                               (c2mop:slot-definition-allocation slot-definition)))))

(defun symbol-to-maybe-reference (symbol)
  (let ((status (nth-value 1 (find-symbol (symbol-name symbol) (symbol-package symbol)))))
    (if (and (eq status :external) (get-tags-value :function symbol))
        (make-instance 'reference :type :function :symbol symbol)
        symbol)))

(defun slot-readers-item (slot-definition)
  (let ((readers (c2mop:slot-definition-readers slot-definition)))
    (and readers
         (make-instance 'item :elements (list (format nil "Readers: ~{~a~^, ~}"
                                                     (mapcar #'symbol-to-maybe-reference readers)))))))

(defun slot-writers-item (slot-definition)
  (let ((writers (c2mop:slot-definition-writers slot-definition)))
    (and writers
         (make-instance 'item :elements (list (format nil "Writers: ~{~a~^, ~}"
                                                     (mapcar #'symbol-to-maybe-reference writers)))))))

(defun slot-properties-itemize (slot-definition)
  (make-instance 'itemize :items `(,(slot-allocation-item slot-definition)
                                   ,@(let ((readers-item (slot-readers-item slot-definition)))
                                       (and readers-item `(readers-item)))
                                   ,@(let ((writers-item (slot-writers-item slot-definition)))
                                       (and writers-item `(writers-item))))))

(defun direct-slots-itemize (class)
  (let ((direct-slots (c2mop:class-direct-slots class)))
    (make-instance 'itemize :items (mapcan (lambda (slot)
                                             (list (slot-name-item slot)
                                                   (slot-properties-itemize slot)))
                                           direct-slots))))

(defun class-direct-slots-itemize (class)
  (make-instance 'itemize :items (list (make-instance 'item :elements (list "Direct slots:"))
                                       (direct-slots-itemize class))))

(defun class-description-direct-slots (class stream)
  (print-element stream (class-direct-slots-itemize class)))

(defmethod print-element (stream (element class-description))
  (with-slots ((name object) tag) element
    (let ((class (find-class name)))
      (class-description-anchor name tag stream)
      (terpri stream)
      (class-description-title class stream)
      (terpri stream)
      (terpri stream)
      (class-description-docstring class stream)
      (terpri stream)
      (terpri stream)
      (class-description-metaclass class stream)
      (terpri stream)
      (class-description-precedence-list class stream)
      (terpri stream)
      (class-description-direct-superclasses class stream)
      (terpri stream)
      (class-description-direct-subclasses class stream)
      (terpri)
      (class-description-direct-slots class stream))))


;; --------------------------------------------------------------------------------
(defclass package-description (description) ())

(defun package-description% (pkg)
  (let* ((package (find-package pkg)))
    (make-instance 'package-description :object package)))

(adp:defmacro package-description (pkg)
  "Inserts a package description. It must receive a package descriptor that represents the package. 
A package description also creates a package tag that can be used with pref."
  `(package-description% ,(string pkg)))

(defmethod process-element ((element package-description))
  (with-slots ((package object)) element
    (let* ((package-name (package-name package))
           (package-key (intern package-name "KEYWORD")))
      (when (not (nth-value 1 (get-tags-value :package package-key)))
        (setf (get-tags-value :package package-key) element)))))

(defun package-description-anchor (name stream)
  (format stream "<a id=~s></a>" (tag-to-string :package name)))

(defun package-description-title (pkg stream)
  (format stream "#### Package: ~a" (package-name pkg)))

(defun package-description-docstring (pkg stream)
  (let* ((docstring (documentation pkg t))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-element-md/" docstring-block)))

(defun package-description-nicknames (pkg stream)
  (format stream "* Nicknames: ~{~a~^, ~}" (package-nicknames pkg)))

(defun package-description-exported-symbols (pkg stream)
  (format stream "* Exported symbols: ")
  (let ((external-symbols '())
        (*print-case* :downcase))
    (do-external-symbols (sym pkg)
      (push (princ-to-string sym) external-symbols))
    (format stream "~{~a~^, ~}" (sort external-symbols #'string<=))))

(defmethod print-element (stream (element package-description))
  (let* ((pkg (slot-value element 'object))
         (name (make-keyword (package-name pkg))))
    (package-description-anchor name stream)
    (terpri stream)
    (package-description-title pkg stream)
    (terpri stream)
    (terpri stream)
    (package-description-docstring pkg stream)
    (terpri stream)
    (terpri stream)
    (package-description-nicknames pkg stream)
    (terpri stream)
    (package-description-exported-symbols pkg stream)))

;; --------------------------------------------------------------------------------
(defclass system-description (description) ())

(defun system-description% (system-des)
  (let* ((system (asdf:find-system system-des)))
    (make-instance 'system-description :object system)))

(adp:defmacro system-description (system-des)
  "Inserts a system description. It must receive a system description that represents the system. 
A system description also creates a system tag that can be used with sref."
  `(system-description% ,(string system-des)))

(defmethod process-element ((element system-description))
  (with-slots ((system object)) element
    (let* ((system-name (asdf:component-name system))
           (system-key (intern (string-upcase system-name) "KEYWORD")))
      (when (not (nth-value 1 (get-tags-value :system system-key)))
        (setf (get-tags-value :system system-key) element)))))

(defun system-description-anchor (name stream)
  (format stream "<a id=~s></a>" (tag-to-string :system name)))

(defun system-description-title (system stream)
  (format stream "#### System: ~a" (asdf:component-name system)))

(defun system-description-docstring (system stream)
  (let* ((docstring (asdf:system-description system))
         (docstring-block (and docstring
                               (make-instance 'code-block :lang "text" :elements (list docstring))
                               (make-instance 'text :style :italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-element-md/" docstring-block)))

(defmacro define-system-description-function (func-name sys-func-name string-name)
  (with-gensyms (obj)
    `(defun ,func-name (system stream)
       (let ((,obj (,sys-func-name system)))
         (when ,obj
           (format stream "* ~a: ~a" ,string-name ,obj)
           (values t))))))

(define-system-description-function system-description-author asdf:system-author "Author")
(define-system-description-function system-description-mail asdf:system-mailto "Mail")
(define-system-description-function system-description-homepage asdf:system-homepage "Homepage")
(define-system-description-function system-description-license asdf:system-licence "License")

(defun system-description-defsystem-depends-on (system stream)
  (let ((dependencies (asdf:system-defsystem-depends-on system)))
    (when dependencies
      (format stream "* Defsystem depends on: ~:[~{~a~^, ~}~;None~]" (null dependencies) dependencies)
      (values t))))

(defun system-description-depends-on (system stream)
  (let ((dependencies (asdf:system-depends-on system)))
    (format stream "* Depends on: ~:[~{~a~^, ~}~;None~]" (null dependencies) dependencies)))

(defmethod print-element (stream (element system-description))
  (let* ((system (slot-value element 'object))
         (name (make-keyword (string-upcase (asdf:component-name system)))))
    (system-description-anchor name stream)
    (terpri stream)
    (system-description-title system stream)
    (terpri stream)
    (terpri stream)
    (system-description-docstring system stream)
    (terpri stream)
    (terpri stream)
    (and (system-description-author system stream)
         (terpri stream))
    (and (system-description-mail system stream)
         (terpri stream))
    (and (system-description-homepage system stream)
         (terpri stream))
    (and (system-description-license system stream)
         (terpri stream))
    (and (system-description-defsystem-depends-on system stream)
         (terpri stream))
    (system-description-depends-on system stream)))
