
(in-package #:adp-github)


(defclass located-element ()
  (source)
  (:documentation
   "An element that stores its location."))


(defgeneric process-element (element)
  (:documentation
   "Process an element.")
  (:method (element)
    (declare (ignore element))
    (values))
  (:method :before ((element located-element))
    (setf (slot-value element 'source) (get-current-file))))

(define-condition process-error (error)
  ((condition :initarg :condition)
   (form :initarg :form))
  (:report (lambda (self stream)
             (with-slots (condition form) self
               (format stream "While processing the form: ~s" form)
               (format stream "~%~a" condition)))))

(defun process-scribble-element (element)
  (let ((value (adp:element-value element))
        (form (adp:element-form element)))
    (handler-case (process-element value)
      (error (c)
        (error 'process-error :condition c :form form)))))

(defvar *context* :md
  "Indicates the current context of text printing.")

(defgeneric print-element (stream element)
  (:documentation
   "Prints an element."))

(define-condition print-error (error)
  ((condition :initarg :condition)
   (form :initarg :form))
  (:report (lambda (self stream)
             (with-slots (condition form) self
               (format stream "While printing the form: ~s" form)
               (format stream "~%~a" condition)))))

(defun print-scribble-element (stream element &optional colon-p at-sign-p)
  (declare (ignore colon-p at-sign-p))
  (let ((value (adp:element-value element))
        (form (adp:element-form element)))
    (handler-case (print-element stream value)
      (error (c)
        (error 'print-error :condition c :form form)))))

(defun format-element (stream element &optional colon-p at-sign-p)
  (declare (ignore colon-p at-sign-p))
  (print-element stream element))

(defun format-element-md (stream object &optional colon-p at-sign-p)
  "Function to be used in FORMAT. Escapes sensitive markdown characters."
  (declare (ignore colon-p at-sign-p))
  (let* ((*context* :md))
    (print-element stream object)))

(defun format-element-html (stream object &optional colon-p at-sign-p)
  "Function to be used in FORMAT. Escapes sensitive markdown characters."
  (declare (ignore colon-p at-sign-p))
  (let* ((*context* :html))
    (print-element stream object)))

(defun format-element-nil (stream object &optional colon-p at-sign-p)
  "Function to be used in FORMAT. Disables any character escape."
  (declare (ignore colon-p at-sign-p))
  (let* ((*context* nil))
    (print-element stream object)))
