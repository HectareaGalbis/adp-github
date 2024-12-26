
(in-package #:adpgh)

(adp:define-adp-system adp-github)

(adp:define-adp-file scribble "scrbl")


(defvar *current-system* nil
  "The current system being processed.")

(defun enough-system-pathname (pathname)
  (let ((system-pathname (asdf:system-source-directory *current-system*)))
    (uiop:enough-pathname pathname system-pathname)))

(defun merge-system-pathname (pathname)
  (let ((system-pathname (asdf:system-source-directory *current-system*)))
    (uiop:merge-pathnames* pathname system-pathname)))

(defmethod adp:export-content ((system adp-github) files)
  (let ((*current-system* system)
        (*print-pprint-dispatch* *adp-pprint-dispatch*)
        (*print-case* :downcase)
        (system-name (asdf:component-name system)))
    (format t "~%* Adding documentation for the system '~a'." system-name)
    (process-files files)
    (format t "~%* Documentation added for the system '~a'." system-name)))
