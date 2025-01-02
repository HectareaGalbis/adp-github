
(in-package #:adp-github)

(defclass glossary ()
  ((descriptions :initarg :descriptions)))

(defmethod process-element ((element glossary))
  (loop for description in (slot-value element 'descriptions)
        do (process-element description)))

(defmethod print-element (stream (element glossary))
  (with-slots (descriptions) element
    (format stream "~{~/adpgh:format-adp-md/~^~%~%~}" descriptions)))

;; --------------------------------------------------------------------------------
(defclass function-glossary (glossary) ())

(defun function-glossary% (pkg)
  (let ((descriptions '()))
    (do-external-symbols (symbol (find-package pkg))
      (when (or (fboundp symbol)
                (macro-function symbol))
        (let* ((instance (make-instance 'function-description :object symbol :tag (make-unique-tag))))
          (push instance descriptions))))
    (let ((sorted-descriptions (sort descriptions #'string<=
                                     :key (lambda (description)
                                            (slot-value description 'object)))))
      (make-instance 'function-glossary :descriptions sorted-descriptions))))

(adp:defmacro function-glossary (pkg)
  "Inserts a function glossary.

It will insert all the available function descriptions from the external symbols of
the given package PKG.
The argument PKG must be a package descriptor (not evaluated)."
  `(function-glossary% ,(string pkg)))


;; --------------------------------------------------------------------------------
(defclass variable-glossary (glossary) ())

(defun variable-glossary% (pkg)
  (let ((descriptions '()))
    (do-external-symbols (symbol (find-package pkg))
      (when (boundp symbol)
        (let* ((instance (make-instance 'variable-description :object symbol :tag (make-unique-tag))))
          (push instance descriptions))))
    (let ((sorted-descriptions (sort descriptions #'string<=
                                     :key (lambda (description)
                                            (slot-value description 'object)))))
      (make-instance 'variable-glossary :descriptions sorted-descriptions))))

(adp:defmacro variable-glossary (pkg)
  "Inserts a variable glossary.

It will insert all the available variable descriptions from the external symbols of
the given package PKG.
The argument PKG must be a package descriptor (not evaluated)."
  `(variable-glossary% ,(string pkg)))


;; --------------------------------------------------------------------------------
(defclass class-glossary (glossary) ())

(defun class-glossary% (pkg)
  (let ((descriptions '()))
    (do-external-symbols (symbol (find-package pkg))
      (when (find-class symbol)
        (let* ((instance (make-instance 'class-description :object symbol :tag (make-unique-tag))))
          (push instance descriptions))))
    (let ((sorted-descriptions (sort descriptions #'string<=
                                     :key (lambda (description)
                                            (slot-value description 'object)))))
      (make-instance 'variable-glossary :descriptions sorted-descriptions))))

(adp:defmacro class-glossary (pkg)
  "Inserts a class glossary.

It will insert all the available class descriptions from the external symbols of
the given package PKG.
The argument PKG must be a package descriptor (not evaluated)."
  `(class-glossary% ,(string pkg)))
