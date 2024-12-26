
(in-package #:adpgh)


(defclass link ()
  ((elements :initarg :elements)
   (address :initarg :address))
  (:documentation
   "Represents a web link."))


(adp:defun link (:address address &rest elements)
  "Inserts a link. It must receive the keyword :address. The rest of the elements will form the name of the
link."
  (check-type address string)
  (make-instance 'link :elements elements :address address))


(defmethod print-element (stream (element link))
  (with-slots (elements address) element
    (format stream "[~{~/adpgh:format-element-md/~}](~a)" elements address)))
