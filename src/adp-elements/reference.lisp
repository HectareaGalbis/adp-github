
(in-package #:adp-github)


(defclass reference (located-element)
  ((type :initarg :type :initform nil)
   (symbol :initarg :symbol :initform nil)
   (text :initarg :text :initform nil)))


(defmacro define-tag-reference (prefix name)
  "Defines a tag reference function."
  (let* ((func-name (symbolicate prefix 'ref))
         (func-aux-name (symbolicate func-name '%))
         (type-string (string-downcase (symbol-name name)))
         (type-keyword (intern (symbol-name name) "KEYWORD"))
         (func-doc (format nil "Inserts a reference to a ~a.~%~%NAME must be a symbol (not evaluated)."
                           type-string)))
    (with-gensyms (name text)
      `(progn

         (defun ,func-aux-name (,name &rest ,text)
           (make-instance 'reference :type ,type-keyword :symbol ,name :text ,text))

         (adp:defmacro ,func-name (,name &rest ,text)
           ,func-doc
           `(,',func-aux-name ',,name ,@,text))))))

(define-tag-reference t title)
(define-tag-reference f function)
(define-tag-reference v variable)
(define-tag-reference c class)

(defun pref% (symbol &rest text)         
  (make-instance 'reference :type :package :symbol symbol :text text))

(adp:defmacro pref (name &rest text)
  "Inserts a reference to a package.

NAME must be a package descriptor (not evaluated)."
  `(pref% ,(make-keyword (string name)) ,@text))

(defun sref% (symbol &rest text)         
  (make-instance 'reference :type :system :symbol symbol :text text))

(adp:defmacro sref (name &rest text)
  "Makes a reference object to a system."
  `(sref% ,(make-keyword (string-upcase (string name))) ,@text))

(defun reference-text (element ref-element)
  "Return the text to be shown in the link."
  (with-slots (type symbol text) element
    (with-slots (object) ref-element
      (ecase type
        ((:function :variable :class)
         (or text (list (prin1-to-string object))))
        ((:title)
         (or text (slot-value ref-element 'elements)))
        ((:package)
         (or text (list (package-name object))))
        ((:system)
         (or text (list (asdf:component-name object))))))))

(defmethod print-element (stream (element reference))
  (with-slots (type symbol) element
    (multiple-value-bind (ref-element found) (get-tags-value type symbol)
      (unless found
        (error "Error: The tag ~s referencing a ~a does not exist."
               symbol (string-downcase (symbol-name type))))
      (let* ((source-file (slot-value ref-element 'source))
             (target-path (get-file-target-pathname source-file)))
        (format stream "[~{~/adpgh:format-adp-md/~}](/~a#~a)"
                (reference-text element ref-element)
                (enough-system-pathname target-path)
                (tag-to-string type symbol))))))


;; --------------------------------------------------------------------------------
(defun clref% (sym)
  (let ((address (hyperspec:lookup sym)))
    (when (not address)
      (error "Error: The value received is not a symbol from the Common Lisp package: ~s" sym))
    (make-instance 'link :address address :elements (list sym))))

(adp:defmacro clref (sym)
  "Inserts a hyperlink to the Common Lisp Hyperspec for a given symbol (not evaluated)."
  `(clref% ',sym))
