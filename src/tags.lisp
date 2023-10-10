
(in-package #:adpgh-core)


(defun make-tags-container ()
  (make-hash-table))

(defun ensure-tag-table (tags type)
  "Returns the hash table of tags of a given type."
  (or (gethash type tags)
      (setf (gethash type tags) (make-hash-table))))

(defun get-tag-value-impl (tags symbol type)
  (let* ((tag-table (ensure-tag-table tags type)))
    (gethash symbol tag-table)))

(defun (setf get-tag-value-impl) (value tags symbol type)
  (let ((tag-table (ensure-tag-table tags type)))
    (setf (gethash symbol tag-table) value)))

(defun get-tag-symbols-impl (tags type)
  (let ((tag-table (ensure-tag-table tags type)))
    (hash-table-keys tag-table)))

(defclass tag ()
  ((symbol :initarg :symbol
           :reader tag-symbol
           :type symbol)
   (type :initarg :type
         :reader tag-type
         :type keyword)))

(defun make-tag (symbol type)
  "Makes a tag."
  (check-type symbol symbol)
  (check-type type keyword)
  (make-instance 'tag :symbol symbol :type type))

(defun tags-tag-value (tags tag)
  "Retreives the value of a tag or nil if tag does not exist."
  (check-type tags hash-table)
  (check-type tag tag)
  (let ((symbol (tag-symbol tag))
        (type (tag-type tag)))
    (get-tag-value-impl tags symbol type)))

(defun (setf tags-tag-value) (value tags tag)
  "Adds or updates a tag."
  (check-type tags hash-table)
  (check-type tag tag)
  (let ((symbol (tag-symbol tag))
        (type (tag-type tag)))
    (setf (get-tag-value-impl tags symbol type) value)))
