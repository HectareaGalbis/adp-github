
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


(defun content-to-string (elements)
  (with-output-to-string (str)
    (loop for element in elements
          do (process-element element str))))


;; ------ text ------
(defmethod process-element ((element string) stream)
  (princ (escape-characters element)))


;; ------ header ------
(defmethod process-element ((element header) stream)
  (let* ((tag (header-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag))
         (text (content-to-string (header-elements element))))
    (format stream "<h1 id=~s>~a</h1>~%~%" (get-symbol-id tagsym tagtype) (escape-html-characters text))))

(defmethod process-element ((element subheader) stream)
  (let* ((tag (header-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag))
         (text (content-to-string (header-elements element))))
    (format stream "<h2 id=~s>~a</h2>~%~%" (get-symbol-id tagsym tagtype) (escape-html-characters text))))

(defmethod process-element ((element subsubheader) stream)
  (let* ((tag (header-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag))
         (text (content-to-string (header-elements element))))
    (format stream "<h3 id=~s>~a</h3>~%~%" (get-symbol-id tagsym tagtype) (escape-html-characters text))))


;; ------ text references ------
(defmethod process-element ((element header-ref) stream)
  (let* ((tag (text-reference-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag))
         (header-obj (get-tag-value tag))
         (target-location (header-target-location header-obj))
         (header-text (or (header-ref-text-elements element)
                          (content-to-string (header-elements header-obj)))))
    (format stream "<a href=\"/~a.md#~a\">~a</a>"
            target-location (get-symbol-id tagsym tagtype) (escape-html-characters header-text))))

(defmethod process-element ((element symbol-reference) stream)
  (let* ((tag (text-reference-tag element))
         (tagsym (tag-symbol tag))
         (tagtype (tag-type tag))
         (definition (get-tag-value tag))
         (target-location (definition-target-location definition)))
    (format stream "<a href=\"/~a.md#~a\">~a</a>"
            target-location (get-symbol-id tagsym tagtype) (escape-html-characters (prin1-to-string tagsym)))))

;; Comprobar si var-ref, fun-ref y type-ref hacen falta o se pueden borrar.


;; ------ table ------
(defmethod process-element ((element cell) stream)
  (let ((content (with-output-to-string (str)
                   (loop for element in (cell-element element)
                         if (and (stringp element)
                                 (string= element "\n"))
                           do (princ "<br>" str)
                         else
                           do (process-element element str)))))
    (format stream "<td>~a</td>" content)))

(defmethod process-element ((element row) stream)
  (let ((content (with-output-to-string (str)
                   (loop for cell in (row-cells element)
                         do (process-element cell str)
                            (terpri str)))))
    (format stream "<tr>~%~a</tr>" content)))

(defmethod process-element ((element table) stream)
  (let ((content (with-output-to-string (str)
                   (loop for row in (table-rows element)
                         do (process-element str)
                            (terpri str)))))
    (format stream "<table>~%~a</table>" content)))


;; ------ itemize ------
(defun process-itemize (item-list numbersp indent-space stream)
  (labels ((digits (n)
             (if (< n 10)
                 1
                 (1+ (digits (truncate n 10))))))
    (loop for item in item-list
          for index = 0 then (if (typep item 'item)
                                 (1+ index)
                                 index)
          do (typecase item
               (item (if numbersp
                         (format stream "~v@{ ~}~s. ~a~%" indent-space (1+ index) (item-elements item))
                         (format stream "~v@{ ~}* ~a~%" indent-space (item-elements item))))
               (itemize (process-itemize (itemize-items item) nil (if numbersp
                                                                      (+ indent-space (digits index) 2)
                                                                      (+ indent-space 2))
                                         stream))
               (enumerate (process-itemize (enumerate-items item) t (if numbersp
                                                                        (+ indent-space (digits index) 2)
                                                                        (+ indent-space 2))
                                           stream))))))

(defmethod process-element ((element itemize) stream)
  (process-itemize (itemize-items element) nil 0 stream))

(defmethod process-element ((element enumerate) stream)
  (process-itemize (enumerate-items element) t 0 stream))


;; ------ text decorators ------
(defmethod process-element ((element bold) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (process-element element str)))))
    (format stream "<strong>~a</strong>" (escape-characters content))))

(defmethod process-element ((element italic) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (process-element element str)))))
    (format stream "<em>~a</em>" (escape-characters content))))

(defmethod process-element ((element emphasis) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (process-element element str)))))
    (format stream "<strong><em>~a</em></strong>" (escape-characters content))))

(defmethod process-element ((element inline) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (process-element element str))))
         (*print-pretty* nil))
    (format stream "``` ~a ```" content)))


;; ------ table of contents ------
(defun file-headers (file)
  "Return the header-type elements of a file."
  (declare (type file file))
  (let ((headers (make-array 10 :adjustable t :fill-pointer 0)))
    (loop for element across (file-elements file)
	  when (typep element 'header-type)
	    do (vector-push-extend element headers))
    (values headers)))

(defun project-headers (files)
  "Return the header-type elements of a project."
  (let ((headers (make-array 10 :adjustable t :fill-pointer 0)))
    (loop for file being the hash-value of files
	  do (let ((file-headers (file-headers file)))
	       (loop for file-header across file-headers
		     if (typep file-header '(or header subheader))
		       do (vector-push-extend file-header headers))))
    (values headers)))

(defun header-deep-level (header)
  "Return the level of deepness of a header."
  (declare (type header-type header))
  (typecase header
    (header 0)
    (subheader 1)
    (subsubheader 2)
    (t (error "The object ~s is not a header-type element." header))))

(defun make-toc-deep-levels (headers)
  "Return a vector of deepness levels the headers must have in a table of contents."
  (declare (type (vector element) headers))
  (let ((deep-levels (make-array 100 :adjustable t :fill-pointer 0 :element-type 'unsigned-byte)))
    (loop for header across headers
	  for prev-min-deep-level = 2 then next-min-deep-level
	  for prev-deep-level =     2 then next-deep-level
	  for (next-min-deep-level next-deep-level) = (let ((header-deep-level (header-deep-level header)))
							(cond
							  ((> header-deep-level prev-deep-level)
							   (let ((next-deep-level (1+ prev-deep-level)))
							     (list prev-min-deep-level next-deep-level)))
							  ((< header-deep-level prev-deep-level)
							   (if (>= header-deep-level prev-min-deep-level)
							       (list prev-min-deep-level (- header-deep-level prev-min-deep-level))
							       (list header-deep-level 0)))
							  (t
							   (list prev-min-deep-level header-deep-level))))
	  do (vector-push-extend next-deep-level deep-levels))
    (values deep-levels)))

(defun make-itemize-toc (headers)
  (let* ((deep-levels (make-toc-deep-levels headers))
	 (total-deep-levels (length deep-levels))
	 (index 0))
    (labels ((make-itemize-toc-aux (current-level)
	       (loop while (< index total-deep-levels)
		     for header = (aref headers index)
		     for deep-level = (aref deep-levels index)
		     until (< deep-level current-level)
		     if (> deep-level current-level)
		       collect (make-instance 'itemize
					      :items (make-itemize-toc-aux (1+ current-level)))
			 into toc-list
		     else
		       collect (make-instance 'item
					      :text-elements (list (make-instance 'header-reference
									     :tag (text-reference-tag header))))
			 into toc-list
			 and do (incf index)
		     finally (return toc-list))))
      (make-instance 'itemize
		     :items (make-itemize-toc-aux 0)))))

(defmethod element-print ((element table-of-contents) stream)
  (with-slots (project) element
    (let ((headers (project-headers *process-files*)))
      (process-element (make-itemize-toc headers) stream))))

(defmethod element-print ((element mini-table-of-contents) stream)
  (with-slots (file) element
    (let ((headers (file-headers *process-content-file*)))
      (process-element (make-itemize-toc headers) stream))))

;; ------ table of functions/types/variables ------
(defun split-symbols (symbols)
  (if (null symbols)
      nil
      (labels ((take-first-symbols (syms char)
		 (let ((sym (car syms)))
		   (cond
		     ((and (not (null syms))
			   (char= (aref (symbol-name sym) 0) char))
		      (multiple-value-bind (rest-first-syms rest) (take-first-symbols (cdr syms) char)
			(values (cons sym rest-first-syms)
				rest)))
		     (t (values nil syms)))))
	       (split-ordered-symbols-aux (syms)
		 (if (null syms)
		     nil
		     (let ((first-sym (car syms)))
		       (multiple-value-bind (first-symbols rest-symbols) (take-first-symbols syms (aref (symbol-name first-sym) 0))
			 (cons first-symbols (split-ordered-symbols-aux rest-symbols)))))))
	(split-ordered-symbols-aux symbols))))

(defun make-itemize-table (tag-table reftype)
  (let* ((syms-list (sort (tag-table-tags tag-table) #'string>=))
	 (split-syms (split-symbols syms-list)))
    (loop for syms-group in split-syms
	  collect (let ((char (aref (symbol-name (car syms-group)) 0)))
		    (make-instance 'item :elements (list char)))
	    into items-list
	  collect (flet ((make-ref (tag)
			   (make-instance reftype :tag tag)))
		    (make-instance 'itemize
				   :items (loop for sym in syms-group
						collect (make-instance 'item
								       :elements (list (make-ref sym))))))
	    into items-list
	  finally (return (make-instance 'itemize :items items-list)))))

(defun make-itemize-tof (source-element)
  (make-itemize-table (get-tag-table :function) 'function-reference))

(defmethod process-element ((element table-of-functions) stream)
  (process-element (make-itemize-tof element) stream))

(defun make-itemize-tos (source-element)
  (make-itemize-table (get-tag-table :variable) 'variable-reference))

(defmethod process-element ((element table-of-symbols) stream)
  (process-element (make-itemize-tos element) stream))

(defun make-itemize-tot (source-element)
  (make-itemize-table (get-tag-table :type) 'type-ref))

(defmethod process-element ((element table-of-types) stream)
  (process-element (make-itemize-tot element) stream))


;; ------ definitions ------
(defmacro define-definition-process (type header-name)
  (with-gensyms (element stream expression tag target-location tagsym tagtype)
    `(defmethod process-element ((,element ,type) ,stream)
       (let ((,expression (definition-expression ,element))
             (,tag (definition-tag ,element))
             (,target-location (definition-target-location ,element))
             (,tagsym (tag-symbol ,tag))
             (,tagtype (tag-type ,tag)))
         (format ,stream "<h4 id=~s>~a: ~a</h4>~%~%"
	         (get-symbol-id ,tagsym ,tagtype) ,header-name (escape-html-characters (princ-to-string (cadr ,expression))))
         (let ((*print-pprint-dispatch* *adp-pprint-dispatch*))
           (format stream "```common-lisp~%")
           (pprint ,expression ,stream)
           (format stream "```"))))))

(define-definition-process defclass-definition "Class")
(define-definition-process defconstant-definition "Constant")
(define-definition-process defgeneric-definition "Generic function")
(define-definition-process define-compiler-macro-definition "Compiler macro")
(define-definition-process define-condition-definition "Condition")
(define-definition-process define-method-combination-definition "Method combination")
(define-definition-process define-modify-macro-definition "Modify macro")
(define-definition-process define-setf-expander-definition "Setf expander")
(define-definition-process define-symbol-macro-definition "Symbol macro")
(define-definition-process defmacro-definition "Macro")
(define-definition-process defmethod-definition "Method")
(define-definition-process defpackage-definition "Package")
(define-definition-process defparameter-definition "Parameter")
(define-definition-process defsetf-definition "Setf")
(define-definition-process defstruct-definition "Struct")
(define-definition-process deftype-definition "Type")
(define-definition-process defun-definition "Function")
(define-definition-process defvar-definition "Variable")
