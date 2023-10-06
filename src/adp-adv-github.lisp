
(in-package #:adpgh-core)


;; ------ advanced macro definitions ------
(defun make-unique-tag ()
  (prog1
      (intern (format nil "~a~a" "HEADERTAG" *header-tag-counter*) "ADP-GH")
    (incf *header-tag-counter*)))

(defmacro adv-header (str &optional tag)
  (when *adp*
    (check-type str string)
    (check-type tag (or null symbol))
    (let ((user-tag-p (and tag t)))
      (let ((fixed-tag-sym (gensym "FIXED-TAG-SYM"))
            (tag-obj (gensym "TAG-OBJ"))
            (header-obj (gensym "HEADER-OBJ")))
        `(progn
	   (let* ((,fixed-tag-sym (or ',tag (make-unique-tag)))
                  (,tag-obj (make-tag :symbol ,fixed-tag-sym :type :header))
                  (,header-obj (make-instance 'header
                                              :elements ,(list str)
					      :user-tag-p ,user-tag-p
                                              :tag ,tag-obj
                                              :target-location (file-target-relative-pathname adp:*load-file*))))
	     (adp:add-element ,header-obj)
             (setf (get-tag-value ,tag-obj ,header-obj)))
	   (values))))))

(defmacro adv-subheader (str &optional tag)
  (when *adp*
    (check-type str string)
    (check-type tag (or null symbol))
    (let ((user-tag-p (and tag t)))
      (let ((fixed-tag-sym (gensym "FIXED-TAG-SYM"))
            (tag-obj (gensym "TAG-OBJ"))
            (header-obj (gensym "HEADER-OBJ")))
        `(progn
	   (let ((,fixed-tag-sym (or ',tag (make-unique-tag)))
                 (,tag-obj (make-tag :symbol ,fixed-tag-sym :type :header))
                 (,header-obj (make-instance 'subheader
                                             :elements ,(list str)
					     :user-tag-p ,user-tag-p
                                             :tag ,tag-obj
                                             :target-location (file-target-relative-pathname adp:*load-file*))))
	     (adp:add-element ,header-obj)
             (setf (get-tag-value ,tag-obj ,header-obj)))
	   (values))))))

(defmacro adv-defmacro (&body defmacro-body)
  `(progn
     ,@(when *adp*
	 (let ((tag-obj (gensym "TAG-OBJ")))
           `((let ((,tag-obj (make-tag :symbol ,(car defmacro-body) :type :function)))
               (adp:add-element (make-instance 'defmacro-definition
					       :expr '(defmacro ,@defmacro-body)
					       :tag ,tag-body))
               (add-tag ,tag-obj)))))
     (defmacro ,@defmacro-body)))

(defmacro adv-defun (&body defun-body)
  `(progn
     ,@(when *adp*
	 (let ((tag-obj (gensym "TAG-OBJ")))
           `((let ((,tag-obj (make-tag :symbol ,(car defun-body) :type :function)))
               (adp:add-element (make-instance 'defun-definition
					       :expr '(defun ,@defun-body)
					       :tag ,tag-body))
               (add-tag ,tag-obj)))))
     (defun ,@defun-body)))
