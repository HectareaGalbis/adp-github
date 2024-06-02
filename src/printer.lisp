
(in-package #:adpgh)


;; ----- Aux functions -----
(defun safe-call (pkg-name func-name &rest args)
  "Checks if a package and a function in that package exists. "
  (let* ((pkg (find-package pkg-name))
         (func (and pkg (find-symbol func-name pkg))))
    (and func (apply func args))))

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


(defvar *context* :md
  "Contains the current context where the text has to be printed.")

(defun escape-md-characters (text)
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

(defun escape-characters (text)
  (case *context*
    (:md (escape-md-characters text))
    (:html (escape-html-characters text))
    (t text)))

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

(defun verbatim-content-to-string (elements)
  (with-output-to-string (str)
    (loop for element in elements
          do (if (stringp element)
                 (princ element str)
                 (export-element element str)))))


;; ------ string ------
(defmethod export-element ((element string) stream)
  (princ (escape-characters element) stream))


;; ------ select-output-file ------
(defmethod export-element ((element select-output-file-type) stream)
  (declare (ignore stream)))


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
         (header-obj (get-tag-value tag)))
    (when (not header-obj)
      (error "Error: The tag ~s of type ~s does not exist."
             (tag-symbol tag) (tag-type tag)))
    (let ((target-location (redirect-path (header-target-location header-obj)))
          (header-elements (or (header-ref-text-elements element)
                               (header-elements header-obj))))
      (format stream "[~a](/~a#~a)"
              (content-to-string header-elements) target-location (tag-to-string tag)))))

(defmethod export-element ((element symbol-reference) stream)
  (let* ((tag (text-reference-tag element))
         (ref-obj (get-tag-value tag)))
    (when (not ref-obj)
      (error "Error: The tag ~s of type ~s does not exist."
             (tag-symbol tag) (tag-type tag)))
    (let ((target-location (redirect-path (description-target-location ref-obj))))
      (format stream "[~a](/~a#~a)"
              (escape-characters (prin1-to-string (tag-symbol tag))) target-location (tag-to-string tag)))))

(defmethod export-element ((element package-reference) stream)
  (let* ((tag (text-reference-tag element))
         (ref-obj (get-tag-value tag)))
    (when (not ref-obj)
      (error "Error: The tag ~s of type ~s does not exist."
             (tag-symbol tag) (tag-type tag)))
    (let ((target-location (redirect-path (description-target-location ref-obj))))
      (format stream "[~a](/~a#~a)"
              (escape-characters (string-downcase (symbol-name (tag-symbol tag))))
              target-location
              (tag-to-string tag)))))

(defmethod export-element ((element system-reference) stream)
  (let* ((tag (text-reference-tag element))
         (ref-obj (get-tag-value tag)))
    (when (not ref-obj)
      (error "Error: The tag ~s of type ~s does not exist."
             (tag-symbol tag) (tag-type tag)))
    (let ((target-location (redirect-path (description-target-location ref-obj))))
      (format stream "[~a](/~a#~a)"
              (escape-characters (string-downcase (symbol-name (tag-symbol tag))))
              target-location
              (tag-to-string tag)))))


;; ------ table ------
(defmethod export-element ((element cell) stream)
  (let* ((*context* :html)
         (content (with-output-to-string (str)
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

(defun make-itemize-tov ()
  (make-itemize-table (get-tag-symbols :variable) 'variable-reference :variable))

(defmethod export-element ((element table-of-variables) stream)
  (export-element (make-itemize-tov) stream))

(defun make-itemize-tocl ()
  (make-itemize-table (get-tag-symbols :class) 'type-ref :class))

(defmethod export-element ((element table-of-classes) stream)
  (export-element (make-itemize-tocl) stream))


;; ------ image ------
(defmethod export-element ((element image) stream)
  (let ((path (image-path element))
        (alt-text (image-alt-text element))
        (scale (image-scale element)))
    (format stream "<img src=\"/~a\" alt=~s width=\"~a%\">"
            path (escape-html-characters alt-text) (floor (* scale 100.0)))))

;; ------ text decorators ------
(defmethod export-element ((element bold) stream)
  (let* ((elements (text-decorator-elements element))
         (content (content-to-string elements)))
    (format stream "**~a**" content)))

(defmethod export-element ((element italic) stream)
  (let* ((elements (text-decorator-elements element))
         (content (content-to-string elements)))
    (format stream "_~a_" content)))

(defmethod export-element ((element emphasis) stream)
  (let* ((elements (text-decorator-elements element))
         (content (content-to-string elements)))
    (format stream "***~a***" content)))

(defmethod export-element ((element inline-code) stream)
  (let* ((elements (text-decorator-elements element))
         (content (verbatim-content-to-string elements))
         (*print-pretty* nil))
    (format stream "``` ~a ```" content)))


;; ------ link ------
(defmethod export-element ((element link) stream)
  (let ((text (content-to-string (link-elements element)))
        (address (link-address element)))
    (format stream "[~a](~a)" text address)))


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
               (princ "<br>" stream)
          do (export-element elem stream))))


;; ------ code-block ------
(defmethod export-element ((element code-of-block) stream)
  (let ((lang (code-block-lang element))
        (elements (code-block-elements element)))
    (format stream "`````~@[~a~]~%~{~a~}~%`````" lang elements)))


;; ------ example ------
(defmethod export-element ((element example) stream)
  (let ((code (example-code element))
        (output (example-output element))
        (results (example-results element)))
    (format stream "`````common-lisp~%~a~%`````~%" code)
    (and (> (length output) 0)
         (format stream "`````text~%~a~%`````~%" output))
    (format stream "`````common-lisp~%~{~s~^~%~%~}~%`````" results)))


;; ------ function description ------
(defun function-description-anchor (tag stream)
  (format stream "<a id=~s></a>" (tag-to-string tag)))

(defun function-description-arguments (symbol stream)
  (let ((arguments (arg:arglist symbol)))
    (when (not (eq arguments :unknown))
      (if (null arguments)
          (princ " ()" stream)
          (let ((*print-right-margin* 999)
                (*print-pprint-dispatch* *argument-pprint-dispatch*))
            (format stream " ~s" arguments))))))

(defun macro-description-title (symbol stream)
  (format stream "#### Macro: ~a" symbol)
  (function-description-arguments symbol stream))

(defun function-description-title (symbol stream)
  (format stream "#### Function: ~a" symbol)
  (function-description-arguments symbol stream))

(defun generic-description-title (symbol stream)
  (format stream "#### Generic function: ~a ~s"
          symbol (c2mop:generic-function-lambda-list (symbol-function symbol))))

(defun function-description-docstring (symbol stream)
  (let* ((docstring (documentation symbol 'function))
         (docstring-block (and docstring
                               (make-instance 'code-of-block :lang "text" :elements (list docstring)))))
    (if docstring-block
        (export-element docstring-block stream)
        (princ "_Undocumented_" stream))
    ;; (princ (or (and docstring (escape-characters docstring)) "_Undocumented_") stream)
    ))

(defmethod export-element ((element function-description) stream)
  (let* ((symbol (description-symbol element))
         (tag (description-tag element)))
    (function-description-anchor tag stream)
    (terpri stream)
    (cond
      ((macro-function symbol)
       (macro-description-title symbol stream))
      ((typep (symbol-function symbol) 'generic-function)
       (generic-description-title symbol stream))
      ((symbol-function symbol)
       (function-description-title symbol stream)))
    (terpri stream)
    (terpri stream)
    (function-description-docstring symbol stream)))


;; ------ variable description ------
(defun variable-description-anchor (tag stream)
  (format stream "<a id=~s></a>" (tag-to-string tag)))

(defun variable-description-title (symbol stream)
  (let ((title (if (constantp symbol) "Constant" "Variable")))
    (format stream "#### ~a: ~a" title (escape-characters (prin1-to-string symbol)))))

;; (defun variable-description-default (symbol stream)
;;   (format stream "* Initial value: ~s" (symbol-value symbol)))

(defun variable-description-docstring (symbol stream)
  (let ((docstring (documentation symbol 'variable)))
    (princ (or (and docstring (escape-characters docstring)) "_Undocumented_") stream)))

(defmethod export-element ((element variable-description) stream)
  (let ((symbol (description-symbol element))
        (tag (description-tag element)))
    (variable-description-anchor tag stream)
    (terpri stream)
    (variable-description-title symbol stream)
    (terpri stream)
    (terpri stream)
    ;; (variable-description-default symbol stream)
    ;; (terpri stream)
    ;; (terpri stream)
    (variable-description-docstring symbol stream)))


;; ------ class description ------
(defun class-description-anchor (tag stream)
  (format stream "<a id=~s></a>" (tag-to-string tag)))

(defun class-description-title (class stream)
  (format stream "#### Class: ~a" (class-name class)))

(defun class-description-docstring (class stream)
  (let ((docstring (documentation class 'type)))
    (princ (or (and docstring (escape-characters docstring)) "_Undocumented_") stream)))

(defun class-description-metaclass (class stream)
  (format stream "* Metaclass: ~a" (class-name (type-of class))))

(defun class-description-precedence-list (class stream)
  (format stream "* Precedence list: ~{~s~^, ~}" (c2mop:class-precedence-list class)))

(defun class-description-direct-superclasses (class stream)
  (format stream "* Direct superclasses: ~{~s~^, ~}" (c2mop:class-direct-superclasses class)))

(defun class-description-direct-subclasses (class stream)
  (format stream "* Direct subclasses: ~{~s~^, ~}" (c2mop:class-direct-subclasses class)))


(defun symbol-to-maybe-reference (symbol)
  (let ((externalp (nth-value 1 (find-symbol (symbol-name symbol) (symbol-package symbol))))
        (tag (make-tag symbol :function)))
    (when (and externalp (get-tag-value tag))
      (make-instance 'variable-reference :tag tag))))

(defun slot-name-item (slot-definition)
  (make-instance 'item :elements (list (format nil "~a :" (c2mop:slot-definition-name slot-definition)))))

(defun slot-allocation-item (slot-definition)
  (make-instance 'item :elements (list (format nil "Allocation: ~a"
                                               (c2mop:slot-definition-allocation slot-definition)))))

(defun slot-readers-item (slot-definition)
  (let ((readers (c2mop:slot-definition-readers slot-definition)))
    (and readers
         (make-instance 'item :elements (list (format nil "Readers: ~{~a~^, ~}"
                                                     (mapcar #'symbol-to-maybe-reference readers)))))))

(defun slot-writers-item (slot-definition)
  (let ((writers (c2mop:slot-definition-writers slot-definition)))
    (and writers
         (make-instance 'item :elements (list (format nil "Writers: ~{~a~^, ~}"
                                                     (mapcar #'symbol-to-maybe-reference writers)))))))

(defun slot-properties-itemize (slot-definition)
  (make-instance 'itemize :items `(,(slot-allocation-item slot-definition)
                                   ,@(let ((readers-item (slot-readers-item slot-definition)))
                                       (and readers-item `(readers-item)))
                                   ,@(let ((writers-item (slot-writers-item slot-definition)))
                                       (and writers-item `(writers-item))))))

(defun direct-slots-itemize (class)
  (let ((direct-slots (c2mop:class-direct-slots class)))
    (make-instance 'itemize :items (apply #'append (mapcar (lambda (slot)
                                                             (list (slot-name-item slot)
                                                                   (slot-properties-itemize slot)))
                                                           direct-slots)))))

(defun class-direct-slots-itemize (class)
  (make-instance 'itemize :items (list (make-instance 'item :elements (list "Direct slots:"))
                                       (direct-slots-itemize class))))

(defun class-description-direct-slots (class stream)
  (export-element (class-direct-slots-itemize class) stream))

(defmethod export-element ((element class-description) stream)
  (let ((class (find-class (description-symbol element)))
        (tag (description-tag element)))
    (class-description-anchor tag stream)
    (terpri stream)
    (class-description-title class stream)
    (terpri stream)
    (terpri stream)
    (class-description-docstring class stream)
    (terpri stream)
    (terpri stream)
    (class-description-metaclass class stream)
    (terpri stream)
    (class-description-precedence-list class stream)
    (terpri stream)
    (class-description-direct-superclasses class stream)
    (terpri stream)
    (class-description-direct-subclasses class stream)
    (terpri)
    (class-description-direct-slots class stream)))


;; ------ package description ------
(defun package-description-anchor (tag stream)
  (format stream "<a id=~s></a>" (tag-to-string tag)))

(defun package-description-title (pkg stream)
  (format stream "#### Package: ~a" (package-name pkg)))

(defun package-description-docstring (pkg stream)
  (let ((docstring (documentation pkg t)))
    (princ (or (and docstring (escape-characters docstring)) "_Undocumented_") stream)))

(defun package-description-nicknames (pkg stream)
  (format stream "* Nicknames: ~{~a~^, ~}" (package-nicknames pkg)))

(defun package-description-exported-symbols (pkg stream)
  (format stream "* Exported symbols: ")
  (let ((external-symbols '())
        (*print-case* :downcase))
    (do-external-symbols (sym pkg)
      (push (princ-to-string sym) external-symbols))
    (format stream "~{~a~^, ~}" (sort external-symbols #'string<=))))

(defmethod export-element ((element package-description) stream)
  (let ((pkg (description-package element))
        (tag (description-tag element)))
    (package-description-anchor tag stream)
    (terpri stream)
    (package-description-title pkg stream)
    (terpri stream)
    (terpri stream)
    (package-description-docstring pkg stream)
    (terpri stream)
    (terpri stream)
    (package-description-nicknames pkg stream)
    (terpri stream)
    (package-description-exported-symbols pkg stream)))


;; ------ system description ------
(defun system-description-anchor (tag stream)
  (format stream "<a id=~s></a>" (tag-to-string tag)))

(defun system-description-title (system stream)
  (format stream "#### System: ~a" (asdf:component-name system)))

(defun system-description-docstring (system stream)
  (let ((docstring (asdf:system-description system)))
    (princ (or (and docstring (escape-characters docstring)) "_No description_") stream)))

(defmacro define-system-description-function (func-name sys-func-name string-name)
  (with-gensyms (obj)
    `(defun ,func-name (system stream)
         (let ((,obj (,sys-func-name system)))
           (and ,obj
                (progn
                  (format stream "* ~a: ~a" ,string-name ,obj)
                  (values t)))))))

(define-system-description-function system-description-author asdf:system-author "Author")
(define-system-description-function system-description-mail asdf:system-mailto "Mail")
(define-system-description-function system-description-homepage asdf:system-homepage "Homepage")
(define-system-description-function system-description-license asdf:system-licence "License")

(defun system-description-defsystem-depends-on (system stream)
  (let ((dependencies (asdf:system-defsystem-depends-on system)))
    (and dependencies
         (progn
           (format stream "* Defsystem depends on: ~:[~{~a~^, ~}~;None~]" (null dependencies) dependencies)
           (values t)))))

(defun system-description-depends-on (system stream)
  (let ((dependencies (asdf:system-depends-on system)))
    (format stream "* Depends on: ~:[~{~a~^, ~}~;None~]" (null dependencies) dependencies)))

(defmethod export-element ((element system-description) stream)
  (let ((system (description-system element))
        (tag (description-tag element)))
    (system-description-anchor tag stream)
    (terpri stream)
    (system-description-title system stream)
    (terpri stream)
    (terpri stream)
    (system-description-docstring system stream)
    (terpri stream)
    (terpri stream)
    (and (system-description-author system stream)
         (terpri stream))
    (and (system-description-mail system stream)
         (terpri stream))
    (and (system-description-homepage system stream)
         (terpri stream))
    (and (system-description-license system stream)
         (terpri stream))
    (and (system-description-defsystem-depends-on system stream)
         (terpri stream))
    (system-description-depends-on system stream)))


;; ------ glossary ------
(defmethod export-element ((element glossary) stream)
  (let ((descriptions (sort (glossary-descriptions element) #'string<= :key #'description-symbol)))
    (when (not (null descriptions))
      (export-element (car descriptions) stream)
      (loop for description in (cdr descriptions)
            do (terpri stream)
               (terpri stream)
               (export-element description stream)))))
