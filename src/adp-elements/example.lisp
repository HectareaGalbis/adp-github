
(in-package #:adp-github)


(defclass example ()
  ((code :initarg :code)
   (output :initarg :output)
   (results :initarg :results)
   (mode :initarg :mode))
  (:documentation
   "Represents an example."))

(defvar *output-modes* '(:both :output :value))

(adp:defun example (:results (mode :both) &rest expressions)
  "Inserts an example.

It is like code-block, but evaluates the code (common lisp only) and prints
its output and returned values.
The tag :RESULTS can be used to select what results should be printed.
It can be one of :BOTH, :OUTPUT, :VALUE or NIL.
By default the :BOTH option is selected and both output and returned values will be printed
if there are any.
If :OUTPUT is selected only output will be printed, if any.
If :VALUE is selected only returned values are printed, if any.
If NIL is selected, neither output nor returned values will be printed."
  (assert (or (not mode) (member mode *output-modes*)) (mode)
          "The :RESULTS mode ~s is not :BOTH, :OUTPUT, :VALUE or NIL." mode)
  (let* ((text-code (format nil "~{~/adpgh:format-lisp-nil/~}" expressions))
         (code (with-input-from-string (text-stream text-code)
                 (loop for expr = (read text-stream nil nil)
                       while expr
                       collect expr))))
    (let* ((output (make-array '(0) :adjustable t :fill-pointer 0 :element-type 'base-char))
           (results (multiple-value-list (with-output-to-string (*standard-output* output)
                                           (let ((*print-pprint-dispatch* *default-pprint-dispatch*))
                                             (let ((*print-case* :upcase)
                                                   (*print-escape* t)
                                                   (*print-shortest-package* nil)
                                                   (*print-gensym-numbers* t)
                                                   (*print-context* nil))
                                               (eval (cons 'progn code)))))))
           (text-results (format nil "~{~s~^~%~}" results)))
      (make-instance 'example :code text-code :output output :results text-results :mode mode))))


(defmethod print-element (stream (element example))
  (with-slots (code output results mode) element
    (format stream "`````common-lisp~%~a~%`````~%" code)
    (when (and (> (length output) 0) (member mode '(:both :output)))
      (format stream "`````text~%;; Output~%~a~%`````~%" output))
    (when (and (> (length results) 0) (member mode '(:both :value)))
      (format stream "`````common-lisp~%;; Returns~%~a~%`````" results))))
