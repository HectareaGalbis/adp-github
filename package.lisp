
(defpackage #:adp-github-core
  (:use #:cl)
  (:nicknames #:adpgh-core))

(defpackage #:adp-github
  (:use #:cl #:adpgh-core)
  (:nicknames #:adpgh)
  (:shadow #:defclass #:defconstant #:defgeneric #:define-compiler-macro #:define-condition
           #:define-method-combination #:define-modify-macro #:define-setf-expander #:define-symbol-macro
           #:defmacro #:defmethod #:defpackage #:defparameter #:defsetf #:defstruct #:deftype #:defun #:defvar
           #:quote #:inline))

(defpackage #:adp-github-scribble
  (:use #:cl)
  (:nicknames #:adpgh-scribble))
