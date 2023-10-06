
(in-package #:adp-gh)


(cl:defun shortest-string (strings)
  "Return the shortest string from a list."
  (declare (type list strings))
  (loop for str in strings
	for shortest = str then (if (< (length str) (length shortest))
				    str
				    shortest)
	finally (return shortest)))

(cl:defun convert-string-case (str)
  (case *print-case*
    (:upcase (string-upcase str))
    (:downcase (string-downcase str))
    (:capitalize (string-capitalize str))
    (t str)))

(cl:defun custom-symbol-pprint-function (stream sym)
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

(cl:defun make-custom-pprint-dispatch ()
  (let ((custom-pprint-dispatch (copy-pprint-dispatch)))    
    (set-pprint-dispatch '(cons (member defclass)) (pprint-dispatch '(cl:defclass)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defconstant)) (pprint-dispatch '(cl:defconstant)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defgeneric)) (pprint-dispatch '(cl:defgeneric)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member define-compiler-macro)) (pprint-dispatch '(cl:define-compiler-macro)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member define-condition)) (pprint-dispatch '(cl:define-condition)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member define-method-combination)) (pprint-dispatch '(cl:define-method-combination)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member define-modify-macro)) (pprint-dispatch '(cl:define-modify-macro)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member define-setf-expander)) (pprint-dispatch '(cl:define-setf-expander)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member define-symbol-macro)) (pprint-dispatch '(cl:define-symbol-macro)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defmacro)) (pprint-dispatch '(cl:defmacro)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defmethod)) (pprint-dispatch '(cl:defmethod)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defpackage)) (pprint-dispatch '(cl:defpackage)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defparameter)) (pprint-dispatch '(cl:defparameter)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defsetf)) (pprint-dispatch '(cl:defsetf)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defstruct)) (pprint-dispatch '(cl:defstruct)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member deftype)) (pprint-dispatch '(cl:deftype)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defun)) (pprint-dispatch '(cl:defun)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch '(cons (member defvar)) (pprint-dispatch '(cl:defvar)) 0 custom-pprint-dispatch)
    (set-pprint-dispatch 'symbol #'custom-symbol-pprint-function 0 custom-pprint-dispatch)
    (values custom-pprint-dispatch)))


(cl:defvar *adp-pprint-dispatch* (make-custom-pprint-dispatch))
