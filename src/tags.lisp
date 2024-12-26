
(in-package #:adpgh)


(defvar *tags* nil
  "The tags container.")

(defun make-unique-tag ()
  "Returns a unique symbol tag."
  (gentemp "TAG"))

(defmacro with-tags (&body body)
  "Evaluates the BODY with a fresh tags container."
  `(let ((*tags* (make-hash-table :test 'eq)))
     ,@body))

(defun ensure-tag-type-container (type)
  "Returns a hash table for agiven keyword type."
  (or (gethash type *tags*)
      (setf (gethash type *tags*) (make-hash-table :test 'eq))))

(defun get-tags-value (type symbol)
  "Return the value associated with a symbol and a type."
  (gethash symbol (ensure-tag-type-container type)))

(defun (setf get-tags-value) (value type symbol)
  "Assigns the value associated with a symbol and a type. Raises an error if tag is already defined."
  (symbol-macrolet ((tag-value (gethash symbol (ensure-tag-type-container type))))
    (if (nth-value 1 tag-value)
        (error "The ~a tag ~s is already defined." (string-downcase (symbol-name type)) symbol)
        (setf tag-value value))))

(defun get-tags-of-type (type)
  "Returns the tags container of the given TYPE as a hash-table."
  (ensure-tag-type-container type))

(defun tag-to-string (type symbol)
  "Returns the string representation of a tag."
  (format nil "~a:~a:~a" (symbol-name type) (package-name (symbol-package symbol)) (symbol-name symbol)))
