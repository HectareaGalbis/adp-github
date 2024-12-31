
(in-package #:adp-github)


(defclass output-file ()
  ((pathname :initarg :pathname)))

(adp:defun output-file (pathname)
  "Specifies the output file of the current scribble file.

The pathname is considered always relative to the project's root directory.
It doesn't print anything."
  (make-instance 'output-file :pathname (pathname pathname)))

(defmethod process-element ((element output-file))
  (with-slots (pathname) element
    (set-user-pathname-as-target-pathname pathname)))

(defmethod print-element (stream (element output-file))
  (declare (ignore stream))
  (values))
