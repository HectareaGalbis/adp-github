
(in-package #:adp-github)


(defclass code-block ()
  ((lang :initarg :lang)
   (elements :initarg :elements))
  (:documentation
   "Represetns a code block."))


(adp:defun code-block (:lang (lang nil) &rest elements)
  "Inserts a code of block. It can receive the keyword :lang, a string that specifies the language to be used.
The rest of elements will be inserted inside a block of code."
  (make-instance 'code-block :lang lang :elements elements))


(defmethod print-element (stream (element code-block))
  (with-slots (lang elements) element
    (format stream "`````~@[~a~]~%~{~/adpgh:format-element-nil/~}~%`````" lang elements)))
