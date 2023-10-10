
(in-package #:adpgh-core)


(defun shortest-string (strings)
  "Return the shortest string from a list."
  (declare (type list strings))
  (loop for str in strings
	for shortest = str then (if (< (length str) (length shortest))
				    str
				    shortest)
	finally (return shortest)))

(defun convert-string-case (str)
  (case *print-case*
    (:upcase (string-upcase str))
    (:downcase (string-downcase str))
    (:capitalize (string-capitalize str))
    (t str)))

(defun custom-symbol-pprint-function (stream sym)
  "Return a custom pprint function to print symbols."
  (let* ((sym-package (symbol-package sym))
	 (nickname (and sym-package
			(shortest-string (package-nicknames sym-package))))
	 (print-package-mode (and sym-package
				  (not (equal sym-package (find-package "CL")))
				  (nth-value 1 (find-symbol (symbol-name sym) sym-package))))
	 (package-to-print (and print-package-mode
				(or nickname
				    (and (keywordp sym) "")
				    (package-name sym-package))))
	 (*print-escape* nil))
    (case print-package-mode
      (:external (format stream "~a:~a"
			 (convert-string-case package-to-print)
			 (convert-string-case (symbol-name sym))))
      (t (format stream "~a" (convert-string-case (symbol-name sym)))))))

(defun make-custom-pprint-dispatch ()
  (let ((custom-pprint-dispatch (copy-pprint-dispatch)))    
    (set-pprint-dispatch '(cons (member adpgh:defclass)) (pprint-dispatch '(defclass)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defconstant)) (pprint-dispatch '(defconstant)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defgeneric)) (pprint-dispatch '(defgeneric)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:define-compiler-macro)) (pprint-dispatch '(define-compiler-macro)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:define-condition)) (pprint-dispatch '(define-condition)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:define-method-combination)) (pprint-dispatch '(define-method-combination)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:define-modify-macro)) (pprint-dispatch '(define-modify-macro)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:define-setf-expander)) (pprint-dispatch '(define-setf-expander)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:define-symbol-macro)) (pprint-dispatch '(define-symbol-macro)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defmacro)) (pprint-dispatch '(defmacro)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defmethod)) (pprint-dispatch '(defmethod)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defpackage)) (pprint-dispatch '(defpackage)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defparameter)) (pprint-dispatch '(defparameter)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defsetf)) (pprint-dispatch '(defsetf)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defstruct)) (pprint-dispatch '(defstruct)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:deftype)) (pprint-dispatch '(deftype)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defun)) (pprint-dispatch '(defun)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member adpgh:defvar)) (pprint-dispatch '(defvar)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch 'symbol #'custom-symbol-pprint-function 0 custom-pprint-dispatch)
    (values custom-pprint-dispatch)))


(defvar *adp-pprint-dispatch* (make-custom-pprint-dispatch))
