
(in-package #:adp-github)

(defparameter *redirections* (make-hash-table :test 'equal)
  "Table of redirections. I.e, maps a path with a new path selected by the user.")

(defun add-redirection (src-path dst-path)
  "Inserts a new redirection or updates it if SRC-PATH is already in the table."
  (setf (gethash src-path *redirections*) dst-path))

(defun redirect-path (path)
  "Returns the redirected path or the path itself if PATH is not in the table.
Also returns whether a redirection has been found."
  (gethash path *redirections* path))
