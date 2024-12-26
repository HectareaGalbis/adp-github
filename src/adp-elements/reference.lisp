
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
         (func-doc (format nil "Makes a reference object to a ~a." type-string)))
    (with-gensyms (symbol text)
      `(progn

         (defun ,func-aux-name (,symbol &rest ,text)
           (make-instance 'reference :type ,type-keyword :symbol ,symbol :text ,text))

         (adp:defmacro ,func-name (,symbol &rest ,text)
           ,func-doc
           `(,',func-aux-name ',,symbol ,@,text))))))

(define-tag-reference t title)
(define-tag-reference f function)
(define-tag-reference v variable)
(define-tag-reference c class)

(defun pref% (symbol &rest text)         
  (make-instance 'reference :type :package :symbol symbol :text text))

(adp:defmacro pref (name &rest text)
  "Makes a reference object to a package."
  `(pref% ,(make-keyword (string name)) ,@text))

(defun sref% (symbol &rest text)         
  (make-instance 'reference :type :system :symbol symbol :text text))

(adp:defmacro sref (name &rest text)
  "Makes a reference object to a system."
  `(sref% ,(make-keyword (string-upcase (string name))) ,@text))

(defun reference-text (element ref-element)
  "Return the text to be shown in the link."
  (with-slots (type symbol text) element
    (ecase type
      ((:function :variable :class)
       (or text (prin1-to-string symbol)))
      ((:title)
       (or text (format nil "~{~a~}" (slot-value ref-element 'elements))))
      ((:package)
       (or text (symbol-name symbol)))
      ((:system)
       (or text (string-downcase (symbol-name symbol)))))))

(defmethod print-element (stream (element reference))
  (with-slots (type symbol) element
    (multiple-value-bind (ref-element found) (get-tags-value type symbol)
      (unless found
        (error "Error: The tag ~s referencing a ~a does not exist."
               symbol (string-downcase (symbol-name type))))
      (format stream "[~/adpgh:format-element-md/](/~a#~a)"
              (reference-text element ref-element)
              (get-current-file-target-pathname)
              (tag-to-string type symbol)))))


;; --------------------------------------------------------------------------------
(defun clref% (sym)
  (let ((address (hyperspec:lookup sym)))
    (when (not address)
      (error "Error: The value received is not a symbol from the Common Lisp package: ~s" sym))
    (make-instance 'link :address address :elements (list (symbol-name sym)))))

(adp:defmacro clref (sym)
  "Inserts a hyperlink to the Common Lisp Hyperspec for a given symbol."
  `(clref% ,(string sym)))
