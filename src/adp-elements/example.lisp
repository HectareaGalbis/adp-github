
(in-package #:adp-github)


(defclass example ()
  ((code :initarg :code)
   (output :initarg :output)
   (results :initarg :results))
  (:documentation
   "Represents an example."))


(adp:defun example (&rest expressions)
  "Inserts an example.

It is like code-block, but evaluates the code (common lisp only) and prints
its output and returned values."
  (let* ((text-code (format nil "~{~/adpgh:format-lisp-nil/~}" expressions))
         (code (with-input-from-string (text-stream text-code)
                 (loop for expr = (read text-stream nil nil)
                       while expr
                       collect expr))))
    (let* ((output (make-array 10 :adjustable t :fill-pointer 0 :element-type 'character))
           (results (multiple-value-list (with-output-to-string (*standard-output* output)
                                           (let ((*print-case* :upcase)
                                                 (*print-escape* t)
                                                 (*print-shortest-package* nil)
                                                 (*print-gensym-numbers* t)
                                                 (*print-context* nil))
                                             (eval (cons 'progn code))))))
           (text-results (format nil "~{~s~^~%~}" results)))
      (make-instance 'example :code text-code :output output :results text-results))))


(defmethod print-element (stream (element example))
  (with-slots (code output results) element
    (format stream "`````common-lisp~%~a~%`````~%" code)
    (when (> (length output) 0)
      (format stream "`````text~%;; Output~%~a~%`````~%" output))
    (when results
      (format stream "`````common-lisp~%;; Returns~%~a~%`````" results))))
