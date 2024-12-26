
(in-package #:adp-github)


;; ------ item ------
(defclass item ()
  ((elements :initarg :elements))
  (:documentation
   "Represents an item in a list of items."))

(adp:defun item (&rest elements)
  "Inserts an element if it is used inside an itemize or enumerate."
  (make-instance 'item :elements elements))

(defmethod print-element (stream (element item))
  (format stream "~{~/adpgh:format-element/~}" (slot-value element 'elements)))


;; ------ list ------
(defclass itemize ()
  ((items :initarg :items)))

(defclass enumerate ()
  ((items :initarg :items)))

(defun print-list (item-list numbersp indent-space stream)
  "Prints a list (itemize or enumerate)"
  (labels ((digits (n) (length (princ-to-string n))))
    (loop for item in item-list
          for index = 0 then (if (typep item 'item) (1+ index) index)
          for next-indent-space = (if numbersp
                                      (+ indent-space (digits index) 2)
                                      (+ indent-space 2))
          do (typecase item
               (item
                (if numbersp
                    (format stream "~v@{ ~}~s. ~/adpgh:format-element/~%" indent-space (1+ index) item)
                    (format stream "~v@{ ~}* ~/adpgh:format-element/~%" indent-space item)))
               (itemize
                (print-list (slot-value item 'items) nil next-indent-space stream))
               (enumerate
                (print-list (slot-value item 'items) t next-indent-space stream))))))


;; ------ itemize ------
(adp:defun itemize (&rest elements)
  "Inserts a list. It can contains items or sublists. The elements must be items, itemizes or enumerates."
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be another list or an item but found: ~s" element))
  (make-instance 'itemize :items elements))

(defmethod print-element (stream (element itemize))
  (print-list (slot-value element 'items) nil 0 stream))


;; ------ enumerate ------
(adp:defun enumerate (&rest elements)
  "Inserts a enumerated lists. It can contain items or sublist. The elements must be items, itemizes or enumerates."
  (loop for element in elements
        when (not (typep element '(or item itemize enumerate)))
          do (error "Each element of a list must be another list or an item but found: ~s" element))
  (make-instance 'enumerate :items elements))

(defmethod print-element (stream (element enumerate))
  (print-list (slot-value element 'items) t 0 stream))
