
(in-package #:adpgh-docs)


(defclass adp-function-description (function-description) ())

(defun adp-function-description% (name)
  (make-instance 'adp-function-description :object name :tag (adpgh::make-unique-tag)))

(defmacro adp-function-description (name)
  "Inserts a function description. It must receive the function name (a symbol) that represents the function. 
A function description also creates a function tag that can be used with fref."
  `(adp-function-description% ',name))

(defun adp-function-description-arguments (name stream)
  (multiple-value-bind (lambda-list success) (adp:function-lambda-list name)
    (when (not success)
      (error "The function or macro ~s is not defined with adp." name))
    (format stream " ~s" lambda-list)))

(defun adp-macro-description-title (name stream)
  (format stream "#### Macro: ~a" name)
  (adp-function-description-arguments name stream))

(defun adp-function-description-title (name stream)
  (format stream "#### Function: ~a" name)
  (adp-function-description-arguments name stream))

(defmethod adpgh::print-element (stream (element adp-function-description))
  (with-slots ((name adpgh::object) (tag adpgh::tag)) element
    (adpgh::function-description-anchor name tag stream)
    (terpri stream)
    (cond
      ((macro-function name)
       (adp-macro-description-title name stream))
      ((symbol-function name)
       (adp-function-description-title name stream)))
    (terpri stream)
    (terpri stream)
    (adpgh::function-description-docstring name stream)))


(defun adp-function-glossary% (pkg)
  (let ((descriptions '()))
    (do-external-symbols (symbol (find-package pkg))
      (when (or (fboundp symbol)
                (macro-function symbol))
        (let* ((instance (make-instance 'adp-function-description :object symbol
                                                                  :tag (adpgh::make-unique-tag))))
          (push instance descriptions))))
    (let ((sorted-descriptions (sort descriptions #'string<=
                                     :key (lambda (description)
                                            (slot-value description 'adpgh::object)))))
      (make-instance 'function-glossary :descriptions sorted-descriptions))))

(defmacro adp-function-glossary (pkg)
  "Inserts a function glossary. It will insert all the available function descriptions.
They are gathered from the external symbols of a given package.
The argument pkg must be a package descriptor."
  `(adp-function-glossary% ,(string pkg)))
