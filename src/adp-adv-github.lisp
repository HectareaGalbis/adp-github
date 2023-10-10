
(in-package #:adpgh-core)

;; ------ advanced macro definitions ------
(defun make-unique-tag ()
  (let ((new-tag (gensym "HEADERTAG")))
    (import new-tag "ADP-GITHUB")
    (values new-tag)))

(defun get-keyword-parameter (key params)
  (cond
    ((null params) nil)
    ((eq key (car params)) (cadr params))
    (t (get-keyword-parameter key (cdr params)))))

(defun remove-keyword-parameters (params)
  (and params
       (let ((key (car params)))
         (if (keywordp key)
             (remove-keyword-parameters (cddr params))
             (cons (car params) (remove-keyword-parameters (cdr params)))))))


;; ------ header ------
(defmacro define-adv-header-function (name type)
  (with-gensyms (tag fixed-tag-sym tag-obj header-obj)
    `(cl:defmacro ,name (&rest args)
       `(let* ((,',tag (get-keyword-parameter :tag ',args))
               (,',fixed-tag-sym (or ,',tag (make-unique-tag)))
               (,',tag-obj (make-tag ,',fixed-tag-sym :header))
               (,',header-obj (make-instance ',',type
                                           :elements (remove-keyword-parameters ',args)
                                           :user-tag-p (and ,',tag t)
                                           :tag ,',tag-obj
                                           :target-location (file-target-relative-pathname *process-file*))))
          (setf (get-tag-value ,',tag-obj) ,',header-obj)
          (values ,',header-obj)))))

(define-adv-header-function adv-header header)
(define-adv-header-function adv-subheader subheader)


(defmacro adv-defmacro (&body body)
  (with-gensyms (tag obj)
    `(progn
       ,@(when adp:*adp*
	   `((let* ((,tag (make-tag ',(car body) :function))
                    (,obj (make-instance 'defmacro-definition
					 :expression '(defmacro ,@body)
					 :tag ,tag
                                         :target-location (file-target-relative-pathname *process-file*))))
               (adp:add-element ,obj)
               (setf (get-tag-value ,tag) ,obj))))
       (defmacro ,@body))))

(defmacro adv-defun (&body body)
  (with-gensyms (tag obj)
    `(progn
       ,@(when adp:*adp*
	   `((let* ((,tag (make-tag ',(car body) :function))
                    (,obj (make-instance 'defun-definition
					 :expression '(defun ,@body)
					 :tag ,tag
                                         :target-location (file-target-relative-pathname *process-file*))))
               (adp:add-element ,obj)
               (setf (get-tag-value ,tag) ,obj))))
       (defun ,@body))))
