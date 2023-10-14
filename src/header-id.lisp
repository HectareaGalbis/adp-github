
(in-package #:adpgh)



(defun tittle-to-id (str)
  (let ((down-str (string-downcase str))
	(simple-str (make-array 100 :adjustable t :fill-pointer 0 :element-type 'character)))
    (loop for down-char across down-str
	  do (cond
               ((or (alphanumericp down-char)
                    (char= down-char #\-))
                (vector-push-extend down-char simple-str))
               ((char= down-char #\space)
                (vector-push-extend #\- simple-str))))
    (values simple-str)))

(defun make-unique-ids-table ()
  (make-hash-table :test 'equal))

(defun unique-ids-tittle-to-id (unique-ids text)
  (let* ((id (tittle-to-id text))
         (unique-num (gethash *unique-ids* id)))
    (cond
      ((not (null unique-num))
       (setf (gethash id *unique-ids*) (1+ unique-num))
       (format nil "~a~a" id unique-num))
      (t
       (setf (gethash id *unique-ids*) 2)
       id))))
