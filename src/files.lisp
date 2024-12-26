
(in-package #:adp-github)


(defvar *file-target-pathnames* nil
  "The target pathnames for each file.")

(defvar *current-file* nil
  "The current file being processed.")

(defmacro with-file-target-pathnames (&body body)
  "Evaluates the BOPY with a fresh hash table of files and target pathnames."
  `(let ((*file-target-pathnames* (make-hash-table :test #'eq)))
     ,@body))

(defmacro with-current-file (file &body body)
  "Evaluates body with the binding of *current-file*."
  `(let ((*current-file* ,file))
     ,@body))

(defun get-current-file ()
  "Returns the current file."
  *current-file*)

(defun get-current-file-target-pathname ()
  "Returns the current target pathname."
  (gethash *current-file* *file-target-pathnames*))

(defun (setf get-current-file-target-pathname) (value)
  "Sets the current target pathname."
  (setf (gethash *current-file* *file-target-pathnames*) value))

(defun get-current-file-pathname ()
  "Returns the current file's pathname."
  (asdf:component-pathname (adp:file-component *current-file*)))

(defun file-pathname-to-target-pathname (file-pathname)
  "Given a pathname of a system's file, returns its target pathname."
  (check-type file-pathname pathname)
  (let ((target-pathname (merge-system-pathname (uiop:merge-pathnames*
                                                 (enough-system-pathname file-pathname)
                                                 (make-pathname :directory '(:relative "docs"))))))
    (uiop:merge-pathnames* (make-pathname :type "md") target-pathname)))

(defun initialize-current-target-pathname ()
  "Initializes the target pathname for the current file."
  (setf (get-current-file-target-pathname)
        (file-pathname-to-target-pathname (asdf:component-pathname (adp:file-component *current-file*)))))

(defun user-pathname-to-target-pathname (user-pathname)
  "Given a user supplied pathname, returns its target pathname."
  (check-type user-pathname pathname)
  (merge-system-pathname (uiop:relativize-pathname-directory user-pathname)))

(defun set-user-pathname-as-target-pathname (user-pathname)
  "Sets a user pathname as the current target pathname."
  (setf (get-current-file-target-pathname)
        (user-pathname-to-target-pathname (pathname user-pathname))))

(defun ensure-target-pathname-directories ()
  "Creates the needed directories to store the current target file."
  (uiop:ensure-all-directories-exist (list (get-current-file-target-pathname))))

(defun process-file (file)
  (with-current-file file
    (let ((relative-file-pathname (enough-system-pathname (get-current-file-pathname))))
      (format t "~%  + Processing elements from: '~a'" relative-file-pathname)
      (initialize-current-target-pathname)
      (loop for element in (adp:file-elements file)
            do (process-scribble-element element)))))

(defun print-file (file)
  (let ((relative-file-pathname (enough-system-pathname (get-current-file-pathname))))
    (format t "~%  + Printing elements from: '~a'" relative-file-pathname)
    (ensure-target-pathname-directories)
    (with-open-file (stream (get-current-file-target-pathname)
                            :direction :output :if-exists :supersede :if-does-not-exist :create)
      (format stream "~{~/adpgh:print-scribble-element/~}" (adp:file-elements file)))))

(define-condition process-file-error (error)
  ((condition :initarg :condition)
   (pathname :initarg :pathname))
  (:report (lambda (self stream)
             (with-slots (condition pathname) self
               (format stream "While processing file: '~a'" pathname)
               (format stream "~%~a" condition)))))

(define-condition print-file-error (error)
  ((condition :initarg :condition)
   (pathname :initarg :pathname))
  (:report (lambda (self stream)
             (with-slots (condition pathname) self
               (format stream "While printing file: '~a'" pathname)
               (format stream "~%~a" condition)))))

(defun process-files (files)
  "Processes the files."
  (with-tags
    (with-file-target-pathnames
      (dolist (file files)
        (with-current-file file
          (handler-case (process-file file)
            (error (c)
              (error 'process-file-error :condition c :pathname (get-current-file-pathname))))))
      (dolist (file files)
        (with-current-file file
          (handler-case (print-file file)
            (error (c)
              (error 'print-file-error :condition c :pathname (get-current-file-pathname)))))))))
