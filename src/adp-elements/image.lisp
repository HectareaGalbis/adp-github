
(in-package #:adp-github)


(defclass image ()
  ((path :initarg :path)
   (alt-text :initarg :alt-text)
   (scale :initarg :scale))
  (:documentation
   "Represents an image."))


(adp:defun image (path :alt-text (alt-text "Image") :scale (scale 1.0))
  "Inserts an image.

It must receive the path to the image (relative to the project's root directory).
Optionally, it can receive an alternative text description and the scale size of the image."
  (make-instance 'image
                 :path (uiop:relativize-pathname-directory (pathname path))
                 :alt-text alt-text :scale scale))

(defmethod print-element (stream (element image))
  (with-slots (path alt-text scale) element
    (format stream "<img src=\"/~a\" alt=\"~/adpgh:format-element-html/\" width=\"~a%\">"
            path alt-text (floor (* scale 100.0)))))
