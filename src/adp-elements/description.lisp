
(in-package #:adp-github)


(defclass description (located-element)
  ((object :initarg :object
           :documentation "The object the description refers to.")
   (tag :initarg :tag
        :documentation "The tag that refers to this description."))
  (:documentation
   "Base class for all descriptions."))


;; --------------------------------------------------------------------------------
(defclass function-description (description) ())

(defun function-description% (name tag)
  (make-instance 'function-description :object name :tag tag))

(adp:defmacro function-description (name :tag (tag (make-unique-tag)))
  "Inserts a function description.

It must receive the function name (a symbol, not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with fref.
The tag must be a symbol (not evaluated)."
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
  (terpri stream)
  (format stream "<a id=~s></a>" (tag-to-string :function tag)))

(defun function-description-arguments (name stream)
  (let ((arguments (arg:arglist name)))
    (when (not (eq arguments :unknown))
      (if (null arguments)
          (princ " ()" stream)
          (let ((*print-right-margin* 999))
            (format stream " ~/adpgh:format-api-md/" arguments))))))

(defun macro-description-title (name stream)
  (format stream "#### Macro: ~/adpgh:format-adp-md/" name)
  (function-description-arguments name stream))

(defun function-description-title (name stream)
  (format stream "#### Function: ~/adpgh:format-adp-md/" name)
  (function-description-arguments name stream))

(defun generic-description-title (name stream)
  (format stream "#### Generic function: ~/adpgh:format-adp-md/" name)
  (let ((*print-right-margin* 999))
    (format-api-md stream (c2mop:generic-function-lambda-list (symbol-function name)))))

(defun function-description-docstring (name stream)
  (let* ((docstring (documentation name 'function))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'text :style :italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-adp-md/" docstring-block)))

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
  (make-instance 'variable-description :object name :tag tag))

(adp:defmacro variable-description (name :tag (tag (make-unique-tag)))
  "Inserts a variable description.

It must receive the variable name (a symbol, not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with vref.
The tag must be a symbol (not evaluated)."
  `(variable-description% ',name ',tag))

(defmethod process-element ((element variable-description))
  (with-slots ((name object) tag) element
    ;; Index and user tag
    (setf (get-tags-value :variable tag) element)
    ;; vref tag
    (when (not (nth-value 1 (get-tags-value :variable name)))
      (setf (get-tags-value :variable name) element))))

(defun variable-description-anchor (name tag stream)
  (format stream "<a id=~s></a>" (tag-to-string :variable name))
  (terpri stream)
  (format stream "<a id=~s></a>" (tag-to-string :variable tag)))

(defun variable-description-title (name stream)
  (let ((title (if (constantp name) "Constant" "Variable")))
    (format stream "#### ~a: ~/adpgh:format-adp-md/" title name)))

(defun variable-description-docstring (name stream)
  (let* ((docstring (documentation name 'variable))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'text :style :italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-adp-md/" docstring-block)))

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
  "Inserts a class description.

It must receive the class name (a symbol, not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with cref.
The tag must be a symbol (not evaluated)."
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
  (terpri stream)
  (format stream "<a id=~s></a>" (tag-to-string :class tag)))

(defun class-description-title (class stream)
  (format stream "#### Class: ~/adpgh:format-adp-md/" (class-name class)))

(defun class-description-docstring (class stream)
  (let* ((docstring (documentation class 'type))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'text :style :italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-adp-md/" docstring-block)))

(defun code-symbol (symbol)
  (make-instance 'text :style :code :elements (list symbol)))

(defun code-class (class)
  (code-symbol (class-name class)))

(defun class-description-metaclass (class stream)
  (format stream "* Metaclass: ~/adpgh:format-adp-md/" (code-class (class-of class))))

(defun class-description-precedence-list (class stream)
  
  (format stream "* Precedence list: ~{~/adpgh:format-adp-md/~^, ~}"
          (mapcar #'code-class (c2mop:class-precedence-list class))))

(defun class-description-direct-superclasses (class stream)
  (let ((superclasses (c2mop:class-direct-superclasses class)))
    (and superclasses
         (format stream "* Direct superclasses: ~{~/adpgh:format-adp-md/~^, ~}"
                 (mapcar #'code-class superclasses)))))

(defun class-description-direct-subclasses (class stream)
  (let ((subclasses (c2mop:class-direct-subclasses class)))
    (and subclasses
         (format stream "* Direct subclasses: ~{~/adpgh:format-adp-md/~^, ~}"
                 (mapcar #'code-class subclasses)))))

(defun slot-name-item (slot-definition)
  (make-instance 'item
                 :elements (list (format nil "~/adpgh:format-adp-md/ :"
                                         (code-symbol (c2mop:slot-definition-name slot-definition))))))

(defun slot-allocation-item (slot-definition)
  (let ((allocation (c2mop:slot-definition-allocation slot-definition)))
    (make-instance 'item :elements (list "Allocation: " (make-instance 'text
                                                                       :style :code
                                                                       :elements (list allocation))))))

(defun slot-documentation-item (slot-definition)
  (let ((docstring (documentation slot-definition t)))
    (and docstring
         (make-instance 'item :elements (list (make-instance 'text :style :code
                                                                   :elements (list docstring)))))))
(defun join-by-element (list element)
  (loop for list-element in (cdr list)
        collect element into result
        collect list-element into result
        finally (return (cons (car list) result))))

(defun slot-readers-item (slot-definition)
  (let ((readers (c2mop:slot-definition-readers slot-definition)))
    (and readers
         (make-instance 'item :elements (list* "Readers: "
                                               (join-by-element (mapcar #'code-symbol readers) ", "))))))

(defun slot-writers-item (slot-definition)
  (let ((writers (c2mop:slot-definition-writers slot-definition)))
    (and writers
         (make-instance 'item :elements (list* "Writers: "
                                               (join-by-element (mapcar #'code-symbol writers) ", "))))))

(defun slot-properties-itemize (slot-definition)
  (make-instance 'itemize :items `(,@(let ((docstring-item (slot-documentation-item slot-definition)))
                                       (and docstring-item `(,docstring-item)))
                                   ,(slot-allocation-item slot-definition)
                                   ,@(let ((readers-item (slot-readers-item slot-definition)))
                                       (and readers-item `(,readers-item)))
                                   ,@(let ((writers-item (slot-writers-item slot-definition)))
                                       (and writers-item `(,writers-item))))))

(defun direct-slots-itemize (class)
  (let* ((direct-slots (c2mop:class-direct-slots class))
         (direct-external-slots (remove-if-not (lambda (direct-slot)
                                                 (let* ((name (c2mop:slot-definition-name direct-slot))
                                                        (symbol-type (nth-value 1 (find-symbol (symbol-name name) (symbol-package name)))))
                                                   (eq symbol-type :external)))
                                               direct-slots)))
    (and direct-external-slots
         (make-instance 'itemize :items (mapcan (lambda (slot)
                                                  (list (slot-name-item slot)
                                                        (slot-properties-itemize slot)))
                                                direct-external-slots)))))

(defun class-direct-slots-itemize (class)
  (let ((direct-slots (direct-slots-itemize class)))
    (and direct-slots
         (make-instance 'itemize :items (list (make-instance 'item :elements (list "Direct slots:"))
                                              direct-slots)))))

(defun class-description-direct-slots (class stream)
  (let ((slots-itemize (class-direct-slots-itemize class)))
    (and slots-itemize
         (format-adp-md stream slots-itemize))))

(defmethod print-element (stream (element class-description))
  (with-slots ((name object) tag) element
    (let ((class (c2mop:ensure-finalized (find-class name))))
      (class-description-anchor name tag stream)
      (terpri stream)
      (class-description-title class stream)
      (terpri stream)
      (class-description-docstring class stream)
      (terpri stream)
      (class-description-direct-slots class stream)
      (terpri stream)
      (terpri stream)
      (class-description-metaclass class stream)
      (terpri stream)
      (class-description-precedence-list class stream)
      (terpri stream)
      (class-description-direct-superclasses class stream)
      (terpri stream)
      (class-description-direct-subclasses class stream))))


;; --------------------------------------------------------------------------------
(defclass package-description (description) ())

(defun package-description% (pkg tag)
  (let* ((package (find-package pkg)))
    (make-instance 'package-description :object package :tag tag)))

(adp:defmacro package-description (pkg :tag (tag (make-unique-tag)))
  "Inserts a function description.

It must receive a package descriptor (not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with pref.
The tag must be a symbol (not evaluated)."
  `(package-description% ,(string pkg) ',tag))

(defmethod process-element ((element package-description))
  (with-slots ((package object) tag) element
    ;; Index and user tag
    (setf (get-tags-value :package tag) element)
    ;; pref tag
    (let* ((package-name (package-name package))
           (package-key (intern package-name "KEYWORD")))
      (when (not (nth-value 1 (get-tags-value :package package-key)))
        (setf (get-tags-value :package package-key) element)))))

(defun package-description-anchor (name tag stream)
  (format stream "<a id=~s></a>" (tag-to-string :package name))
  (terpri stream)
  (format stream "<a id=~s></a>" (tag-to-string :package tag)))

(defun package-description-title (pkg stream)
  (format stream "#### Package: ~/adpgh:format-adp-md/" (package-name pkg)))

(defun package-description-docstring (pkg stream)
  (let* ((docstring (documentation pkg t))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'text :style :italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-adp-md/" docstring-block)))

(defun package-description-nicknames (pkg stream)
  (format stream "* Nicknames: ~{~/adpgh:format-adp-md/~^, ~}" (package-nicknames pkg)))

(defun package-description-exported-symbols (pkg stream)
  (format stream "* Exported symbols: ")
  (let ((external-symbols '()))
    (do-external-symbols (sym pkg)
      (push (string-downcase (symbol-name sym)) external-symbols))
    (format stream "~{~/adpgh:format-adp-md/~^, ~}" (mapcar #'code-symbol (sort external-symbols #'string<=)))))

(defmethod print-element (stream (element package-description))
  (let* ((pkg (slot-value element 'object))
         (tag (slot-value element 'tag))
         (name (make-keyword (package-name pkg))))
    (package-description-anchor name tag stream)
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

(defun system-description% (system-des tag)
  (let* ((system (asdf:find-system system-des)))
    (make-instance 'system-description :object system :tag tag)))

(adp:defmacro system-description (system-des :tag (tag (make-unique-tag)))
  "Inserts a system description.

It must receive a system descriptor (not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with sref.
The tag must be a symbol (not evaluated)."
  `(system-description% ,(string-downcase (string system-des)) ',tag))

(defmethod process-element ((element system-description))
  (with-slots ((system object) tag) element
    ;; Index and user tag
    (setf (get-tags-value :system tag) element)
    ;; sref tag
    (let* ((system-name (asdf:component-name system))
           (system-key (intern (string-upcase system-name) "KEYWORD")))
      (when (not (nth-value 1 (get-tags-value :system system-key)))
        (setf (get-tags-value :system system-key) element)))))

(defun system-description-anchor (name tag stream)
  (format stream "<a id=~s></a>" (tag-to-string :system name))
  (terpri stream)
  (format stream "<a id=~s></a>" (tag-to-string :system tag)))

(defun system-description-title (system stream)
  (format stream "#### System: ~/adpgh:format-adp-md/" (asdf:component-name system)))

(defun system-description-docstring (system stream)
  (let* ((docstring (asdf:system-description system))
         (docstring-block (if docstring
                              (make-instance 'code-block :lang "text" :elements (list docstring))
                              (make-instance 'text :style :italic :elements '("Undocumented")))))
    (format stream "~/adpgh:format-adp-md/" docstring-block)))

(defmacro define-system-description-function (func-name sys-func-name string-name)
  (with-gensyms (obj)
    `(defun ,func-name (system stream)
       (let ((,obj (,sys-func-name system)))
         (when ,obj
           (format stream "* ~/adpgh:format-adp-md/: ~/adpgh:format-adp-md/" ,string-name ,obj)
           (values t))))))

(define-system-description-function system-description-author asdf:system-author "Author")
(define-system-description-function system-description-mail asdf:system-mailto "Mail")
(define-system-description-function system-description-homepage asdf:system-homepage "Homepage")
(define-system-description-function system-description-license asdf:system-licence "License")

(defun system-description-defsystem-depends-on (system stream)
  (let ((dependencies (asdf:system-defsystem-depends-on system)))
    (when dependencies
      (format stream "* Defsystem depends on: ~:[~{~/adpgh:format-adp-md/~^, ~}~;None~]"
              (null dependencies) dependencies)
      (values t))))

(defun system-description-depends-on (system stream)
  (let ((dependencies (asdf:system-depends-on system)))
    (format stream "* Depends on: ~:[~{~/adpgh:format-adp-md/~^, ~}~;None~]" (null dependencies) dependencies)))

(defmethod print-element (stream (element system-description))
  (let* ((system (slot-value element 'object))
         (tag (slot-value element 'tag))
         (name (make-keyword (string-upcase (asdf:component-name system)))))
    (system-description-anchor name tag stream)
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
