
(in-package #:adp-github)


(defclass title (located-element)
  ((elements :initarg :elements)
   (level :initarg :level)
   (tag :initarg :tag)
   (toc :initarg :toc)))

(adp:defun title*% (:tag (tag (make-unique-tag)) :toc (toc t) :level (level 0) &rest title-elements)
  (make-instance 'title :elements title-elements :level level :tag tag :toc toc))

(adp:defmacro title* (:tag (tag (make-unique-tag)) :toc (toc t) :level (level 0) &rest title-elements)
  "Inserts a title of a given LEVEL.

It can be referenced with tref if a TAG is specified.
If TOC is NIL it won't appear at any table of contents.
The LEVEL specifies the title level. 0 is a title, 1 is a subtitle, etc."
  `(title*% :tag ',tag :toc ,toc :level ,level ,@title-elements))

(adp:defmacro title (:tag (tag (make-unique-tag)) :toc (toc t) &rest title-elements)
  "Inserts a title of level 0.

It can be referenced if a TAG is specified (not evaluated).
If TOC is NIL it won't appear at any table of contents."
  `(title* :tag ,tag :toc ,toc :level 0 ,@title-elements))

(adp:defmacro subtitle (:tag (tag (make-unique-tag)) :toc (toc t) &rest title-elements)
  "Returns a subtitle of level 1.

It can be referenced if a TAG is specified (not evaluated).
If TOC is NIL it won't appear at any table of contents."
  `(title* :tag ,tag :toc ,toc :level 1 ,@title-elements))

(adp:defmacro subsubtitle (:tag (tag (make-unique-tag)) :toc (toc t) &rest title-elements)
  "Returns a title of level 2.

It can be referenced if a TAG is specified (not evaluated).
If TOC is NIL it won't appear at any table of contents."
  `(title* :tag ,tag :toc ,toc :level 2 ,@title-elements))

(defmethod process-element ((element title))
  (setf (get-tags-value :title (slot-value element 'tag)) element))

(defmethod print-element (stream (element title))
  (with-slots (elements level tag) element
    (format stream "<a id=~s></a>~%" (tag-to-string :title tag))
    (format stream "~v@{#~} ~{~/adpgh:format-adp-md/~}" (1+ level) elements)))
