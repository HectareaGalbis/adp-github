
(in-package #:adpgh-core)

(adp:define-adp-operation adp-github-op)


(defvar *tags* nil)
(defvar *process-file* nil)
(defvar *files* nil)
(defvar *export-file* nil)
(defvar *unique-ids* nil)

(defmethod adp:pre-process-system ((o adp-github-op) s)
  (setf *tags* (make-tags-container)))

(defmethod adp:pre-process-file ((o adp-github-op) f)
  (setf *process-file* f))

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
  (if (and (string= (pathname-name path) "README")
           (string= (pathname-type path) "scrbl"))
      (merge-pathnames (make-pathname :type "md") path)
      (merge-pathnames (make-pathname :directory (pathname-directory path) :name (pathname-name path) :type "md")
                       (make-pathname :directory '(:relative "docs")))))


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

(defun file-target-absolute-pathname (file-component)
  (let ((system (asdf:component-system file-component)))
    (asdf:system-relative-pathname system (src-to-target-pathname (component-relative-pathname file-component)))))

(defgeneric export-element (element stream)
  (:method ((element t) stream)
    (princ element stream)))


(defmethod adp:export-content ((op adp-github-op) files system)
  (let ((*files* files))
    (loop for file across files
          do (let* ((*export-file* file)
                    (content (with-output-to-string (stream)
                               (loop for element across (adp:file-elements file)
                                     do (export-element element stream))))
                    (target-path (file-target-absolute-pathname (adp:file-component file))))
               (warn "Exporting ~a" (asdf:system-relative-pathname system target-path))
               (ensure-directories-exist target-path)
               (with-open-file (file-str target-path :direction :output :if-exists :supersede
                                                     :if-does-not-exist :create)
                 (princ content file-str))
               (warn "Completed"))))
  (setf *tags* nil))

;; (maphash (lambda (file-path file)
;;                (declare (ignore file-path))
;;                (let* ((*export-file* file)
;;                       (content (with-output-to-string (stream)
;;                                  (loop for element across (adp:file-elements file)
;;                                        do (export-element element stream))))
;;                       (target-path (file-target-absolute-pathname (adp:file-component file))))
;;                  (warn "Exporting ~a" (asdf:system-relative-pathname system target-path))
;;                  (ensure-directories-exist target-path)
;;                  (with-open-file (file-str target-path :direction :output :if-exists :supersede
;;                                                        :if-does-not-exist :create)
;;                    (princ content file-str))
;;                  (warn "Completed")))
;;              files)
