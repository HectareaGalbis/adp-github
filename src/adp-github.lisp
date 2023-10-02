
(in-package #:adp-gh)

(adp:define-adp-operation adp-github-op)


(defvar *tags* nil)
(defvar *current-target-path* nil)

(defun get-tag-value (tag)
  (tags-tag-value *tags* tag))

(defun (setf get-tag-value) (value tag)
  (setf (tags-tag-value *tags* tag) value))


(defun src-to-target-pathname (path)
  (if (and (string= (pathname-name path) "README")
           (string= (pathname-type path) "sbcrl"))
      (merge-pathnames (make-pathname :type "md") path)
      (merge-pathnames (make-pathname :directory '(:relative "docs") :type "md") path)))

(defun file-target-relative-pathname (file-component)
  (src-to-target-pathname (asdf:component-relative-pathname file-component)))

(defun file-target-absolute-pathname (file-component)
  (src-to-target-pathname (asdf:component-pathname file-component)))


(defgeneric process-element (element stream)
  (:method ((element t) stream)
    (princ element stream)))


(defmethod adp:export-content ((op adp-plain-op) files system)
  (maphash (lambda (file-path file)
             (let* ((*tags* (create-tags-container))
                    (*current-target-path* (file-target-relative-pathname file))
                    
                    
                    (content (with-output-to-string (stream)
                               (loop for element across (adp:file-elements file)
                                     do (process-element element stream))))
                    (target-path (file-target-absolute-pathname file)))
               (warn "Exporting ~a" (asdf:system-relative-pathname target-path))
               (with-open-file (file-str target-path :direction :output :if-exists :supersede
                                                     :if-does-not-exist :create)
                 (princ content file-str))
               (warn "Completed")))
           files))
