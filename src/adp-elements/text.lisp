
(in-package #:adpgh)

(defclass text ()
  ((style :initarg :style)
   (elements :initarg :elements)))

(adp:defun text (:style style &rest elements)
  "Returns a text object."
  (make-instance 'text :style style :elements elements))

(defmacro define-text-decorator (name)
  (let* ((name-str (string-downcase (symbol-name name)))
         (name-key (intern (symbol-name name) "KEYWORD"))
         (docstring (format nil "Inserts text with ~a style." name-str)))
    `(adp:defun ,name (&rest elements)
       ,docstring
       (make-instance 'text :style ,name-key :elements elements))))

(define-text-decorator bold)
(define-text-decorator italic)
(define-text-decorator emphasis)
(define-text-decorator code)

(defmethod print-element (stream (element text))
  (with-slots (style elements) element
    (let ((style-str (ecase style
                       ((nil) "")
                       (:bold "**")
                       (:italic "_")
                       (:emphasis "***")
                       (:code "```"))))
      (if (eq style :code)
          (format stream "~a~{~/adpgh:format-element-nil/~}~a" style-str elements style-str)
          (format stream "~a~{~/adpgh:format-element-md/~}~a" style-str elements style-str)))))
