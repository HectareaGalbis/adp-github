
(in-package #:adpgh)

(defvar *default-pprint-dispatch* *print-pprint-dispatch*
  "The default pprint dispatch.")

(defvar *print-shortest-package* nil
  "Indicates if the symbol package to print must the shortest name or nickname.")

(defun shortest-string (strings)
  (declare (type list strings))
  (loop for str in strings
	for shortest = str then (if (< (length str) (length shortest))
				    str
				    shortest)
	finally (return shortest)))

(defun get-shortest-package-name (sym)
  (let ((package (symbol-package sym)))
    (shortest-string
     (cons (package-name package)
           (package-nicknames package)))))

(defvar *print-gensym-numbers* t
  "Indicates if the last numbers of an uninterned symbol must be printed.")

(defun remove-numbers-tail (str)
  (let ((length-str (length str)))
    (loop for i downfrom (1- length-str) to 0 by 1
          while (digit-char-p (aref str i))
          finally (return (subseq str 0 (1+ i))))))

(defmacro with-symbol-parts ((package separator name) sym &body body)
  `(ppcre:register-groups-bind (,package ,separator ,name)
       ("^(?:([^#:]*)?(::|:|#:))?([^#:]+)$" (write-to-string ,sym))
     (let ((,package (or ,package ""))
           (,separator (or ,separator ""))
           (,name (or ,name "")))
       ,@body)))

(defun custom-symbol-pprint-function (stream sym)
  (let ((*print-pprint-dispatch* *default-pprint-dispatch*))
    (with-symbol-parts (package separator name) sym
      (when (and (not (emptyp package)) *print-shortest-package*)
        (setf package (princ-to-string (make-symbol (get-shortest-package-name sym)))))
      (when (keywordp sym)
        (setf separator ":"))
      (when (and (not (symbol-package sym)) (not *print-gensym-numbers*))
        (setf name (princ-to-string (make-symbol (remove-numbers-tail (symbol-name sym))))))
      (format stream "~a~a~a" package separator name))))

(defun make-custom-symbol-pprint-dispatch ()
  (let ((custom-symbol-pprint-dispatch (copy-pprint-dispatch nil)))    
    (set-pprint-dispatch '(and symbol (not null)) #'custom-symbol-pprint-function 0 custom-symbol-pprint-dispatch)
    (values custom-symbol-pprint-dispatch)))

(defvar *custom-symbol-pprint-dispatch* (make-custom-symbol-pprint-dispatch)
  "Custom symbol pprint dispatch of ADP.")

(defmacro with-custom-symbol-pprint-dispatch (&body body)
  "Establishes custom symbol pprint dispatch."
  `(let ((*print-pprint-dispatch* *custom-symbol-pprint-dispatch*))
     ,@body))

;; --------------------------------------------------------------------------------
(defvar *adp-pprint-dispatch* *custom-symbol-pprint-dispatch*
  "Default pprint dispatch of ADP.")

(defmacro with-adp-pprint-dispatch (&body body)
  "Establishes the pprint dispatch for printing in the ADP style."
  `(let ((*print-pprint-dispatch* *adp-pprint-dispatch*))
     ,@body))
