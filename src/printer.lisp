
(in-package #:adpgh-core)


;; ----- Aux functions -----
(defun convert-to-github-header-anchor (str)
  (let ((down-str (string-downcase str))
	(simple-str (make-array 100 :adjustable t :fill-pointer 0 :element-type 'character)))
    (loop for down-char across down-str
	  do (cond
               ((or (alphanumericp down-char)
                    (char= down-char #\-))
                (vector-push-extend down-char simple-str))
               ((char= down-char #\space)
                (vector-push-extend #\- simple-str))))
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


(defun tag-to-string (tag)
  (let ((tagsym (tag-symbol tag))
        (tagtype (tag-type tag)))
    (format nil "~a-~a-~a"
            (string-downcase (symbol-name tagtype))
            (string-downcase (package-name (symbol-package tagsym)))
            (string-downcase (symbol-name tagsym)))))


(defun content-to-string (elements)
  (with-output-to-string (str)
    (loop for element in elements
          do (export-element element str))))


;; ------ string ------
(defmethod export-element ((element string) stream)
  (princ (escape-characters element) stream))


;; ------ header ------
(defmacro define-header-process-method (type level)
  `(defmethod export-element ((element ,type) stream)
     (let* ((tag (header-tag element))
            (text (content-to-string (header-elements element))))
       (format stream "<a id=~s></a>~%"
               (tag-to-string tag))
       (format stream "~v@{#~} ~a"
               ,level text))))

(define-header-process-method header 1)
(define-header-process-method subheader 2)
(define-header-process-method subsubheader 3)


;; ------ text ------
(defmethod export-element ((element text) stream)
  (let ((text-elements (text-elements element)))
    (loop for text-element in text-elements
          do (export-element text-element stream))))


;; ------ text references ------
(defmethod export-element ((element header-reference) stream)
  (let* ((tag (text-reference-tag element))
         (header-obj (get-tag-value tag))
         (target-location (header-target-location header-obj))
         (header-text (or (header-ref-text-elements element)
                          (content-to-string (header-elements header-obj)))))
    (format stream "[~a](/~a#~a)"
            (escape-characters header-text) target-location (tag-to-string tag))))

(defmethod export-element ((element symbol-reference) stream)
  (let* ((tag (text-reference-tag element))
         (ref-obj (get-tag-value tag)))
    (when (not ref-obj)
      (error "Error: The tag ~s of type ~s does not exist."
             (tag-symbol tag) (tag-type tag)))
    (let ((target-location (definition-target-location ref-obj)))
      (format stream "[~a](/~a#~a)"
              (escape-characters (prin1-to-string (tag-symbol tag))) target-location (tag-to-string tag)))))


;; ------ table ------
(defmethod export-element ((element cell) stream)
  (let ((content (with-output-to-string (str)
                   (loop for element in (cell-elements element)
                         if (and (stringp element)
                                 (string= element "\n"))
                           do (princ "<br>" str)
                         else
                           do (export-element element str)))))
    (format stream "<td>~a</td>" content)))

(defmethod export-element ((element row) stream)
  (let ((content (with-output-to-string (str)
                   (loop for cell in (row-cells element)
                         do (export-element cell str)
                            (terpri str)))))
    (format stream "<tr>~%~a</tr>" content)))

(defmethod export-element ((element table) stream)
  (let ((content (with-output-to-string (str)
                   (loop for row in (table-rows element)
                         do (export-element row str)
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
                         (format stream "~v@{ ~}~s. ~a~%" indent-space (1+ index) (content-to-string (item-elements item)))
                         (format stream "~v@{ ~}* ~a~%" indent-space (content-to-string (item-elements item)))))
               (itemize (process-itemize (itemize-items item) nil (if numbersp
                                                                      (+ indent-space (digits index) 2)
                                                                      (+ indent-space 2))
                                         stream))
               (enumerate (process-itemize (enumerate-items item) t (if numbersp
                                                                        (+ indent-space (digits index) 2)
                                                                        (+ indent-space 2))
                                           stream))))))

(defmethod export-element ((element itemize) stream)
  (process-itemize (itemize-items element) nil 0 stream))

(defmethod export-element ((element enumerate) stream)
  (process-itemize (enumerate-items element) t 0 stream))


;; ------ table of contents ------
(defun file-headers (file)
  "Return the header-type elements of a file."
  (let ((headers (make-array 10 :adjustable t :fill-pointer 0)))
    (loop for element across (adp:file-elements file)
	  when (typep element 'header-type)
	    do (vector-push-extend element headers))
    (values headers)))

(defun project-headers (files)
  "Return the header-type elements of a project."
  (let ((headers (make-array 10 :adjustable t :fill-pointer 0)))
    (loop for file across files
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
					      :elements (list (make-instance 'header-reference
									          :tag (header-tag header))))
			 into toc-list
			 and do (incf index)
		     finally (return toc-list))))
      (make-instance 'itemize
		     :items (make-itemize-toc-aux 0)))))

(defmethod export-element ((element table-of-contents) stream)
  (with-slots (project) element
    (let ((headers (project-headers *files*)))
      (export-element (make-itemize-toc headers) stream))))

(defmethod export-element ((element mini-table-of-contents) stream)
  (with-slots (file) element
    (let ((headers (file-headers *export-file*)))
      (export-element (make-itemize-toc headers) stream))))

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

(defun make-itemize-table (tagsyms reftype tagtype)
  (let* ((syms-list (sort tagsyms #'string>=))
	 (split-syms (split-symbols syms-list)))
    (loop for syms-group in split-syms
	  collect (let ((char (aref (symbol-name (car syms-group)) 0)))
		    (make-instance 'item :elements (list char)))
	    into items-list
	  collect (flet ((make-ref (tagsym)
			   (make-instance reftype :tag (make-tag tagsym tagtype))))
		    (make-instance 'itemize
				   :items (loop for sym in syms-group
						collect (make-instance 'item
								       :elements (list (make-ref sym))))))
	    into items-list
	  finally (return (make-instance 'itemize :items items-list)))))

(defun make-itemize-tof ()
  (make-itemize-table (get-tag-symbols :function) 'function-reference :function))

(defmethod export-element ((element table-of-functions) stream)
  (export-element (make-itemize-tof) stream))

(defun make-itemize-tos ()
  (make-itemize-table (get-tag-symbols :variable) 'variable-reference :variable))

(defmethod export-element ((element table-of-symbols) stream)
  (export-element (make-itemize-tos) stream))

(defun make-itemize-tot ()
  (make-itemize-table (get-tag-symbols :type) 'type-ref :type))

(defmethod export-element ((element table-of-types) stream)
  (export-element (make-itemize-tot) stream))


;; ------ image ------
(defmethod export-element ((element image) stream)
  (let ((path (image-path element))
        (alt-text (image-alt-text element))
        (scale (image-scale element)))
    (format stream "<img src=\"/~a\" alt=~s width=\"~a%\">"
            path (escape-html-characters alt-text) (floor scale))))

;; ------ text decorators ------
(defmethod export-element ((element bold) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (export-element element str)))))
    (format stream "<strong>~a</strong>" (escape-characters content))))

(defmethod export-element ((element italic) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (export-element element str)))))
    (format stream "<em>~a</em>" (escape-characters content))))

(defmethod export-element ((element emphasis) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element across elements
                          do (export-element element str)))))
    (format stream "<strong><em>~a</em></strong>" (escape-characters content))))

(defmethod export-element ((element inline-code) stream)
  (let* ((elements (text-decorator-elements element))
         (content (with-output-to-string (str)
                    (loop for element in elements
                          do (export-element element str))))
         (*print-pretty* nil))
    (format stream "``` ~a ```" content)))


;; ------ link ------
(defmethod export-element ((element link) stream)
  (let ((name (link-name element))
        (address (link-address element)))
    (format stream "[~a](~a)" (escape-characters name) address)))


;; ------ quote ------
(defmethod export-element ((element quoted) stream)
  (let ((elements (quote-elements element))
        (quote-sym t))
    (loop for elem in elements
          if quote-sym
            do (princ "> " stream)
               (setf quote-sym nil)
          if (and (stringp elem)
                  (char= #\linefeed (aref elem 0)))
            do (setf quote-sym t)
          do (export-element elem stream))))


;; ------ code-block ------
(defun code-to-string (expr)
  "Turn a code element into a string."
  (let ((*print-pprint-dispatch* *adp-pprint-dispatch*))
    (prin1-to-string expr)))

(defmethod export-element ((element code-block) stream)
  (let ((expressions (code-block-expressions element)))
    (format stream "`````common-lisp~%~{~a~^~%~%~}~%`````" (mapcar #'code-to-string expressions))))


;; ------ verbatim-code-block ------
(defmethod export-element ((element verbatim-code-block) stream)
  (let ((lang (verbatim-code-block-lang element))
        (elements (verbatim-code-block-elements element)))
    (format stream "`````~a~%~{~a~}~%`````" lang elements)))


;; ------ definitions ------
(defmacro define-definition-process (type header-name)
  (with-gensyms (element stream expression tag)
    `(defmethod export-element ((,element ,type) ,stream)
       (let ((,expression (definition-expression ,element))
             (,tag (and (typep ,element 'tagged-definition)
                        (definition-tag ,element))))
         (format ,stream "<h4~a>~a: ~a</h4>~%~%"
	         (if ,tag
                     (format nil " id=~s" (tag-to-string ,tag))
                     "")
                 ,header-name (escape-html-characters (princ-to-string (cadr ,expression))))
         (let ((*print-pprint-dispatch* *adp-pprint-dispatch*))
           (format ,stream "```common-lisp~%")
           (prin1 ,expression ,stream)
           (format ,stream "~%```"))))))

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
