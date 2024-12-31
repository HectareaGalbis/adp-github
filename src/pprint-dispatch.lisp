
(in-package #:adpgh)


(defun make-regular-pprint-dispatch ()
  (copy-pprint-dispatch nil))

(defvar *regular-pprint-dispatch* (make-regular-pprint-dispatch)
  "A copy of the initial pprint dispatch.")

(defmacro with-regular-pprint-dispatch (&body body)
  `(let ((*print-pprint-dispatch* *regular-pprint-dispatch*)
         (*print-case* :upcase))
     ,@body))

;; --------------------------------------------------------------------------------
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
				(or (and (keywordp sym) "")
                                    nickname
				    (package-name sym-package))))
         (name-to-print (if sym-package (symbol-name sym) (remove-numbers-tail (symbol-name sym))))
	 (*print-escape* nil))
    (case print-package-mode
      (:external (format stream "~a:~a"
			 (convert-string-case package-to-print)
			 (convert-string-case name-to-print)))
      (t (format stream "~a" (convert-string-case name-to-print))))))

(defun make-custom-pprint-dispatch ()
  (let ((custom-pprint-dispatch (copy-pprint-dispatch nil)))    
    (set-pprint-dispatch 'symbol #'custom-symbol-pprint-function 0 custom-pprint-dispatch)
    (values custom-pprint-dispatch)))


(defvar *adp-pprint-dispatch* (make-custom-pprint-dispatch)
  "Default pprint dispatch of ADP.")

(defmacro with-adp-pprint-dispatch (&body body)
  "Establishes the values for printing in the ADP style."
  `(let ((*print-pprint-dispatch* *adp-pprint-dispatch*)
         (*print-case* :downcase))
     ,@body))

;; --------------------------------------------------------------------------------
(defun remove-numbers-tail (str)
  (let ((length-str (length str)))
    (loop for i downfrom (1- length-str) to 0 by 1
          while (digit-char-p (aref str i))
          finally (return (subseq str 0 (1+ i))))))

(defun api-symbol-pprint-function (stream sym)
  (when (keywordp sym)
    (princ ":" stream))
  (let ((name-to-print (if (symbol-package sym) (symbol-name sym) (remove-numbers-tail (symbol-name sym)))))
    (princ (convert-string-case name-to-print) stream)))

(defun make-api-pprint-dispatch ()
  (let ((api-pprint-dispatch (copy-pprint-dispatch)))    
    (set-pprint-dispatch 'symbol #'api-symbol-pprint-function 0 api-pprint-dispatch)
    (values api-pprint-dispatch)))

(defvar *api-pprint-dispatch* (make-api-pprint-dispatch))

(defmacro with-api-pprint-dispatch (&body body)
  `(let ((*print-pprint-dispatch* *api-pprint-dispatch*)
         (*print-right-margin* 999)
         (*print-case* :downcase))
     ,@body))
