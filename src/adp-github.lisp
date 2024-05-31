
(in-package #:adpgh)

(adp:define-adp-operation adp-github-op)

(adp:define-adp-file scribble "scrbl")

(defvar *tags* nil)
(defvar *process-system* nil)
(defvar *process-file* nil)
(defvar *files* nil)
(defvar *export-file* nil)
(defvar *unique-ids* nil)

(defmethod adp:pre-process-system ((o adp-github-op) s)
  (setf *tags* (make-tags-container))
  (setf *process-system* s))

(defmethod adp:pre-process-file ((o adp-github-op) f)
  (setf *process-file* f))

(defmethod adp:post-process-system ((o adp-github-op) s)
  (setf *process-system* nil))

(defmethod adp:post-process-file ((o adp-github-op) f)
  (setf *process-file* nil))


(defun get-tag-value (tag)
  (tags-tag-value *tags* tag))

(defun (setf get-tag-value) (value tag)
  (setf (tags-tag-value *tags* tag) value))

(defun get-tag-symbols (type)
  (get-tag-symbols-impl *tags* type))


;; (defun get-unique-id (text)
;;   (unique-ids-tittle-to-id *unique-ids* text))

(defun src-to-target-pathname (path)
  (merge-pathnames (make-pathname :directory (pathname-directory path) :name (pathname-name path) :type "md")
                   (make-pathname :directory '(:relative "docs"))))


(defun component-relative-pathname (file-component)
  (labels ((faux (fcomp-dir system-dir)
             (if (or (null system-dir)
                     (null (cdr system-dir)))
                 fcomp-dir
                 (faux (cons :relative (cddr fcomp-dir)) (cons :relative (cddr system-dir))))))
    (let ((file-path (asdf:component-pathname file-component))
          (system-path (asdf:component-pathname (asdf:component-system file-component))))
      (make-pathname :directory (faux (pathname-directory file-path) (pathname-directory system-path))
                     :name (pathname-name file-path)
                     :type (pathname-type file-path)))))

(defun file-target-relative-pathname (file-component)
  (src-to-target-pathname (component-relative-pathname file-component)))

(defun file-target-absolute-pathname (system path &optional redirectedp)
  (asdf:system-relative-pathname system (if redirectedp path (src-to-target-pathname path))))

(defgeneric export-element (element stream)
  (:method ((element t) stream)
    (princ element stream)))


(defmethod adp:export-content ((op adp-github-op) files system)
  (let ((*files* files)
        (*print-case* :downcase))
    (loop for file across files
          do (let* ((*export-file* file)
                    (content (with-output-to-string (stream)
                               (let ((*print-pprint-dispatch* *adp-pprint-dispatch*))
                                 (loop for element across (adp:file-elements file)
                                       do (export-element element stream))))))
               (multiple-value-bind (target-path redirectedp)
                   (redirect-path (file-target-relative-pathname (adp:file-component file)))
                 (let ((target-file (file-target-absolute-pathname
                                     (asdf:component-system (adp:file-component file))
                                     target-path
                                     redirectedp)))
                   (warn "Exporting ~a" (asdf:system-relative-pathname system target-file))
                   (ensure-directories-exist target-file)
                   (with-open-file (file-str target-file :direction :output :if-exists :supersede
                                                         :if-does-not-exist :create)
                     (princ content file-str))
                   (warn "Completed"))))))
  (setf *tags* nil))
