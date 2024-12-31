
(in-package #:adp-github)


(defvar *current-system* nil
  "The current system being processed.")

(defmacro with-current-system (system &body body)
  "Evaluates body with the binding of *current-system*."
  `(let ((*current-system* ,system))
     ,@body))

(defun enough-system-pathname (pathname)
  "Given a PATHNAME under the system's directory, returns a relative pathname to it.
An error is thrown if PATHNAME is not under the SYSTEM's root directory."
  (check-type pathname pathname)
  (assert (uiop:absolute-pathname-p pathname))
  (let ((system-dir (asdf:system-source-directory *current-system*)))
    (or (uiop:subpathp pathname system-dir)
        (error "Expected ~s to be under ~s" pathname system-dir))))

(defun merge-system-pathname (pathname)
  "Given a relative PATHNAME, merges it with the SYSTEM's root directory."
  (check-type pathname pathname)
  (assert (uiop:relative-pathname-p pathname))
  (uiop:merge-pathnames* pathname (asdf:system-source-directory *current-system*)))

(defun process-system (system files)
  "Processes the system and its files."
  (let ((system-name (asdf:component-name system)))
    (format t "~%Adding documentation for the system '~a'." system-name)
    (with-current-system system
      (process-files files))
    (format t "~%Documentation added for the system '~a'." system-name)))
