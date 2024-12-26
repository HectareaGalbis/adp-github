
(in-package #:adp-github)


(defclass quoted ()
  ((elements :initarg :elements))
  (:documentation
   "Represents a quote."))


(adp:defun quoted (&rest elements)
  "Inserts quoted text."
  (make-instance 'quoted :elements elements))

(defmethod print-element (stream (element quoted))
  (with-slots (elements) element
    (let ((quote-sym t))
      (loop for elem in elements
            if quote-sym
              do (princ "> " stream)
                 (setf quote-sym nil)
            if (and (stringp elem)
                    (char= #\Newline (aref elem 0)))
              do (setf quote-sym t)
                 (princ "<br>" stream)
            do (print-element stream elem)))))
