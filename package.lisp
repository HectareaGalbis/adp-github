
;; (defpackage #:adp-github-core
;;   (:use #:cl #:alexandria)
;;   (:nicknames #:adpgh-core)
;;   (:export #:make-tag #:row-cells #:get-tag-value #:file-target-relative-pathname  #:*process-file*
;;            #:adv-header #:adv-subheader #:header-target-location #:adv-defmacro #:adv-defun

;;            #:header #:subheader #:subsubheader #:text #:header-reference #:variable-reference
;;            #:function-reference #:type-reference #:cell #:row #:table #:item #:itemize #:enumerate
;;            #:table-of-contents #:mini-table-of-contents #:table-of-functions #:table-of-symbols #:table-of-types
;;            #:image #:bold #:italic #:emphasis #:inline-code #:link #:quoted #:code-of-block
;;            #:verbatim-code-of-block #:example 

;;            #:description #:function-description 
           
;;            #:defclass-definition #:defconstant-definition #:defgeneric-definition
;;            #:define-compiler-macro-definition #:define-condition-definition
;;            #:define-method-combination-definition #:define-modify-macro-definition
;;            #:define-setf-expander-definition #:define-symbol-macro-definition #:defmacro-definition
;;            #:defmethod-definition #:defpackage-definition #:defparameter-definition #:defsetf-definition
;;            #:defstruct-definition #:deftype-definition #:defun-definition #:defvar-definition))

(defpackage #:adp-github
  (:use #:cl #:alexandria)
  (:nicknames #:adpgh)
  ;; (:shadow #:defclass #:defconstant #:defgeneric #:define-compiler-macro #:define-condition
  ;;          #:define-method-combination #:define-modify-macro #:define-setf-expander #:define-symbol-macro
  ;;          #:defmacro #:defmethod #:defpackage #:defparameter #:defsetf #:defstruct #:deftype #:defun #:defvar
  ;;          #:inline)
  (:export #:header #:subheader #:subsubheader #:text #:href #:fref #:vref #:tref #:cell #:row #:table #:item
           #:itemize #:enumerate #:table-of-contents #:mini-table-of-contents #:table-of-functions
           #:table-of-symbols #:table-of-types #:image #:bold #:italic #:emphasis #:inline #:link #:quoted
           #:code-block #:verbatim-code-block #:example

           #:function-description #:function-glossary
           
           ;; #:defclass #:defconstant #:defgeneric #:define-compiler-macro #:define-condition
           ;; #:define-method-combination #:define-modify-macro #:define-setf-expander #:define-symbol-macro
           ;; #:defmacro #:defmethod #:defpackage #:defparameter #:defsetf #:defstruct #:deftype #:defun #:defvar
           ))
