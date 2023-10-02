
(in-package #:adp-gh)


;; ----- Aux functions -----
(defun convert-to-github-header-anchor (str)
  (let ((down-str (string-downcase str))
	(simple-str (make-array 100 :adjustable t :fill-pointer 0 :element-type 'character)))
    (loop for down-char across down-str
	  do (when (or (alphanumericp down-char)
		       (char= down-char #\space)
		       (char= down-char #\-))
	       (vector-push-extend down-char simple-str)))
    (loop for i from 0 below (fill-pointer simple-str)
	  do (when (char= (aref simple-str i) #\space)
	       (setf (aref simple-str i) #\-)))
    (values simple-str)))

(defun symbol-github-name (sym)
  (let* ((sym-name (symbol-name sym))
	 (length-name (length sym-name)))
    (if (and (char= (aref sym-name 0) #\*)
	     (char= (aref sym-name (1- length-name)) #\*))
	(format nil "\\*~a\\*" (subseq sym-name 1 (1- length-name)))
	(format nil "~a" sym))))

(defun escape-characters (text)
  (let ((punctuation-chars '(#\! #\" #\# #\$ #\% #\& #\' #\( #\) #\* #\+ #\, #\- #\. #\/ #\: #\; #\< #\= #\> #\? #\@ #\[ #\\ #\] #\^ #\_ #\` #\{ #\| #\} #\~))
	(fixed-text (make-array (length text) :adjustable t :fill-pointer 0 :element-type 'character)))
    (loop for char across text
	  when (member char punctuation-chars :test #'char=)
	    do (vector-push-extend #\\ fixed-text)
	  do (vector-push-extend char fixed-text))
    (values fixed-text)))

(defun escape-html-characters (text)
  (let ((punctuation-chars '((#\< . "&#60;")
			     (#\> . "&#62;")))
	(fixed-text (make-array (length text) :adjustable t :fill-pointer 0 :element-type 'character)))
    (with-output-to-string (stream fixed-text)
      (loop for char across text
	    for code = (cdr (assoc char punctuation-chars))
	    if code
	      do (princ code stream)
	    else
	      do (princ char stream)))    
    (values fixed-text)))

(defun symbol-macro-p (sym &optional env)
  (let ((*macroexpand-hook* (constantly nil)))
    (nth-value 1 (macroexpand-1 sym env))))


(defun get-symbol-id (sym type)
  (let ((type-str (ecase type
		    (:header "header")
		    (:symbol "symbol")
		    (:function "function")
		    (:type "type"))))
    (format nil "~a:~a:~a" type-str (package-name (symbol-package sym)) (symbol-name sym))))


;; ------ text ------
(cl:defmethod process-element ((element string) stream)
  (princ (escape-characters element)))


;; ------ header ------
(cl:defmethod process-element ((element header) stream)
  (let* ((tag (header-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag)))
    (format stream "<h1 id=~s>~a</h1>~%~%" (get-symbol-id tagsym tagtype) (escape-html-characters text))))

(cl:defmethod process-element ((element subheader) stream)
  (let* ((tag (header-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag)))
    (format stream "<h2 id=~s>~a</h2>~%~%" (get-symbol-id tagsym tagtype) (escape-html-characters text))))

(cl:defmethod process-element ((element subsubheader) stream)
  (let* ((tag (header-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag)))
    (format stream "<h3 id=~s>~a</h3>~%~%" (get-symbol-id tagsym tagtype) (escape-html-characters text))))


;; ------ text decorators ------
(cl:defmethod process-element ((element bold) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (process-element element str)))))
    (format stream "<strong>~a</strong>" (escape-characters content))))

(cl:defmethod process-element ((element italic) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (process-element element str)))))
    (format stream "<em>~a</em>" (escape-characters content))))

(cl:defmethod process-element ((element emphasis) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (process-element element str)))))
    (format stream "<strong><em>~a</em></strong>" (escape-characters content))))

(cl:defmethod process-element ((element inline) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (process-element element str))))
         (*print-pretty* nil))
    (format stream "``` ~a ```" content)))


;; ------ text references ------
(cl:defmethod process-element ((element header-ref) stream)
  (let* ((tag (text-reference-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag))
         (header-obj (get-tag-value tag)))
    (format stream "<a href=\"/~a.md#~a\">~a</a>"
            *current-target-pathname* (get-symbol-id tagsym tagtype) (escape-html-characters ))))
