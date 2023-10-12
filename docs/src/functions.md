<a id="header-adp-github-headertag775"></a>
# Reference

This is the list of functions and macros defined by ``` ADP\-GITHUB ```\. Almost all these functions can be used in both lisp and text mode\. However\, the last macros that define things\, must only be used in lisp mode\.

<a id="header-adp-github-headertag776"></a>
## Lisp and text mode functions

<a id="function-adp-github-core-header"></a>
#### Macro: header

```common-lisp
(defmacro adpgh-core:header (&rest args)
  (list (quote let*)
        (list
         (list 'tag777
               (list (quote get-keyword-parameter) (quote :tag)
                     (list (quote quote) args)))
         (list 'fixed-tag-sym778
               (list (quote or) 'tag777 (quote (make-unique-tag))))
         (list 'tag-obj779
               (list (quote adpgh-core:make-tag) 'fixed-tag-sym778
                     (quote :header)))
         (list 'header-obj780
               (list (quote make-instance)
                     (list (quote quote) 'adpgh-core:header) (quote :elements)
                     (list (quote remove-keyword-parameters)
                           (list (quote quote) args))
                     (quote :user-tag-p) (list (quote and) 'tag777 (quote t))
                     (quote :tag) 'tag-obj779 (quote :target-location)
                     (quote
                      (adpgh-core:file-target-relative-pathname
                       adpgh-core:*process-file*)))))
        (list (quote setf) (list (quote adpgh-core:get-tag-value) 'tag-obj779)
              'header-obj780)
        (list (quote values) 'header-obj780)))
```

<a id="function-adp-github-core-subheader"></a>
#### Macro: subheader

```common-lisp
(defmacro adpgh-core:subheader (&rest args)
  (list (quote let*)
        (list
         (list 'tag783
               (list (quote get-keyword-parameter) (quote :tag)
                     (list (quote quote) args)))
         (list 'fixed-tag-sym784
               (list (quote or) 'tag783 (quote (make-unique-tag))))
         (list 'tag-obj785
               (list (quote adpgh-core:make-tag) 'fixed-tag-sym784
                     (quote :header)))
         (list 'header-obj786
               (list (quote make-instance)
                     (list (quote quote) 'adpgh-core:subheader)
                     (quote :elements)
                     (list (quote remove-keyword-parameters)
                           (list (quote quote) args))
                     (quote :user-tag-p) (list (quote and) 'tag783 (quote t))
                     (quote :tag) 'tag-obj785 (quote :target-location)
                     (quote
                      (adpgh-core:file-target-relative-pathname
                       adpgh-core:*process-file*)))))
        (list (quote setf) (list (quote adpgh-core:get-tag-value) 'tag-obj785)
              'header-obj786)
        (list (quote values) 'header-obj786)))
```

<a id="function-adp-github-core-subsubheader"></a>
#### Macro: subsubheader

```common-lisp
(defmacro adpgh-core:subsubheader (&rest args)
  (list (quote let*)
        (list
         (list 'tag789
               (list (quote get-keyword-parameter) (quote :tag)
                     (list (quote quote) args)))
         (list 'fixed-tag-sym790
               (list (quote or) 'tag789 (quote (make-unique-tag))))
         (list 'tag-obj791
               (list (quote adpgh-core:make-tag) 'fixed-tag-sym790
                     (quote :header)))
         (list 'header-obj792
               (list (quote make-instance)
                     (list (quote quote) 'adpgh-core:subsubheader)
                     (quote :elements)
                     (list (quote remove-keyword-parameters)
                           (list (quote quote) args))
                     (quote :user-tag-p) (list (quote and) 'tag789 (quote t))
                     (quote :tag) 'tag-obj791 (quote :target-location)
                     (quote
                      (adpgh-core:file-target-relative-pathname
                       adpgh-core:*process-file*)))))
        (list (quote setf) (list (quote adpgh-core:get-tag-value) 'tag-obj791)
              'header-obj792)
        (list (quote values) 'header-obj792)))
```

<a id="function-adp-github-core-text"></a>
#### Function: text

```common-lisp
(defun adpgh-core:text (&rest elements)
  (make-instance 'adpgh-core:text :elements elements))
```

<a id="function-adp-github-href"></a>
#### Macro: href

```common-lisp
(defmacro adpgh:href (sym)
  (list (quote make-instance) (list (quote quote) 'adpgh-core:header-reference)
        (quote :tag)
        (list (quote adpgh-core:make-tag) (list (quote quote) sym) ':header)))
```

<a id="function-adp-github-fref"></a>
#### Macro: fref

```common-lisp
(defmacro adpgh:fref (sym)
  (list (quote make-instance)
        (list (quote quote) 'adpgh-core:function-reference) (quote :tag)
        (list (quote adpgh-core:make-tag) (list (quote quote) sym) ':function)))
```

<a id="function-adp-github-vref"></a>
#### Macro: vref

```common-lisp
(defmacro adpgh:vref (sym)
  (list (quote make-instance)
        (list (quote quote) 'adpgh-core:variable-reference) (quote :tag)
        (list (quote adpgh-core:make-tag) (list (quote quote) sym) ':variable)))
```

<a id="function-adp-github-tref"></a>
#### Macro: tref

```common-lisp
(defmacro adpgh:tref (sym)
  (list (quote make-instance) (list (quote quote) 'adpgh-core:type-reference)
        (quote :tag)
        (list (quote adpgh-core:make-tag) (list (quote quote) sym) ':type)))
```

<a id="function-adp-github-core-cell"></a>
#### Function: cell

```common-lisp
(defun adpgh-core:cell (&rest elements)
  (make-instance 'adpgh-core:cell :elements elements))
```

<a id="function-adp-github-core-row"></a>
#### Function: row

```common-lisp
(defun adpgh-core:row (&rest elements)
  (loop for element in elements
        when (not (typep element 'adpgh-core:cell))
        do (error "Each element of a row must be a cell."))
  (make-instance 'adpgh-core:row :cells elements))
```

<a id="function-adp-github-core-table"></a>
#### Function: table

```common-lisp
(defun adpgh-core:table (&rest elements)
  (assert (> (length elements) 0))
  (let ((num-cells (length (adpgh-core:row-cells (car elements)))))
    (loop for element in elements
          for row-num-cells = (length (adpgh-core:row-cells element))
          when (not (eql num-cells row-num-cells))
          do (error "Every row must have the same number of elements.")
          when (not (typep element 'adpgh-core:row))
          do (error "Each element of a table must be a row.")))
  (make-instance 'adpgh-core:table :rows elements))
```

<a id="function-adp-github-core-item"></a>
#### Function: item

```common-lisp
(defun adpgh-core:item (&rest elements)
  (make-instance 'adpgh-core:item :elements elements))
```

<a id="function-adp-github-core-itemize"></a>
#### Function: itemize

```common-lisp
(defun adpgh-core:itemize (&rest elements)
  (loop for element in elements
        when (not
              (typep element
                     '(or adpgh-core:item adpgh-core:itemize
                          adpgh-core:enumerate)))
        do (error "Each element of a list must be an item."))
  (make-instance 'adpgh-core:itemize :items elements))
```

<a id="function-adp-github-core-enumerate"></a>
#### Function: enumerate

```common-lisp
(defun adpgh-core:enumerate (&rest elements)
  (loop for element in elements
        when (not
              (typep element
                     '(or adpgh-core:item adpgh-core:itemize
                          adpgh-core:enumerate)))
        do (error "Each element of a list must be an item."))
  (make-instance 'adpgh-core:enumerate :items elements))
```

<a id="function-adp-github-core-table-of-contents"></a>
#### Function: table\-of\-contents

```common-lisp
(defun adpgh-core:table-of-contents ()
  (make-instance 'adpgh-core:table-of-contents))
```

<a id="function-adp-github-core-mini-table-of-contents"></a>
#### Function: mini\-table\-of\-contents

```common-lisp
(defun adpgh-core:mini-table-of-contents ()
  (make-instance 'adpgh-core:mini-table-of-contents))
```

<a id="function-adp-github-core-table-of-functions"></a>
#### Function: table\-of\-functions

```common-lisp
(defun adpgh-core:table-of-functions ()
  (make-instance 'adpgh-core:table-of-functions))
```

<a id="function-adp-github-core-table-of-symbols"></a>
#### Function: table\-of\-symbols

```common-lisp
(defun adpgh-core:table-of-symbols ()
  (make-instance 'adpgh-core:table-of-symbols))
```

<a id="function-adp-github-core-table-of-types"></a>
#### Function: table\-of\-types

```common-lisp
(defun adpgh-core:table-of-types () (make-instance 'adpgh-core:table-of-types))
```

<a id="function-adp-github-core-image"></a>
#### Function: image

```common-lisp
(defun adpgh-core:image (path &key (alt-text "Image") (scale 1.0))
  (make-instance 'adpgh-core:image :path path :alt-text alt-text :scale scale))
```

<a id="function-adp-github-core-bold"></a>
#### Function: bold

```common-lisp
(defun adpgh-core:bold (&rest elements)
  (make-instance 'adpgh-core:bold :elements elements))
```

<a id="function-adp-github-core-italic"></a>
#### Function: italic

```common-lisp
(defun adpgh-core:italic (&rest elements)
  (make-instance 'adpgh-core:italic :elements elements))
```

<a id="function-adp-github-core-emphasis"></a>
#### Function: emphasis

```common-lisp
(defun adpgh-core:emphasis (&rest elements)
  (make-instance 'adpgh-core:emphasis :elements elements))
```

<a id="function-adp-github-inline"></a>
#### Function: inline

```common-lisp
(defun adpgh:inline (&rest elements)
  (make-instance 'adpgh-core:inline-code :elements elements))
```

<a id="function-adp-github-core-link"></a>
#### Function: link

```common-lisp
(defun adpgh-core:link (name address)
  (make-instance 'adpgh-core:link :name name :address address))
```

<a id="function-adp-github-quote"></a>
#### Function: quote

```common-lisp
(defun adpgh:quote (&rest elements)
  (make-instance 'adpgh-core:quoted :elements elements))
```

<a id="function-adp-github-core-code-block"></a>
#### Macro: code\-block

```common-lisp
(defmacro adpgh-core:code-block (&rest expressions)
  (list (quote make-instance) (quote 'adpgh-core:code-block)
        (quote :expressions) (list (quote quote) expressions)))
```

<a id="function-adp-github-core-verbatim-code-block"></a>
#### Function: verbatim\-code\-block

```common-lisp
(defun adpgh-core:verbatim-code-block (lang &rest elements)
  (make-instance 'adpgh-core:verbatim-code-block :lang lang :elements elements))
```

<a id="function-adp-github-core-example"></a>
#### Macro: example

```common-lisp
(defmacro adpgh-core:example (&rest expressions)
  (alexandria-1:with-gensyms (output result)
    (list (quote let*)
          (list
           (list output
                 (quote
                  (make-array 10 :adjustable t :fill-pointer 0 :element-type
                              'character)))
           (list result
                 (list (quote multiple-value-list)
                       (list* (quote with-output-to-string)
                              (list (quote *standard-output*) output)
                              expressions))))
          (list (quote make-instance) (quote 'adpgh-core:example)
                (quote :expressions) (list (quote quote) expressions)
                (quote :output) output (quote :result) result))))
```

<a id="header-adp-github-headertag847"></a>
## Only lisp mode functions

<a id="function-adp-github-defclass"></a>
#### Macro: defclass

```common-lisp
(defmacro adpgh:defclass (&body body)
  "Add a defclass declaration. The macro expands to cl:defclass. Also, the class name is used to create a type-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag848
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':type)))
                    (list
                     (list 'obj849
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defclass-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defclass body))
                                  (list (quote :tag) 'tag848
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj849)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag848)
                          'obj849)))))
         (list (cons 'defclass body)))))
```

<a id="function-adp-github-defconstant"></a>
#### Macro: defconstant

```common-lisp
(defmacro adpgh:defconstant (&body body)
  "Add a defconstant declaration. The macro expands to cl:defconstant. Also, the constant name is used to create a symbol-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag852
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':variable)))
                    (list
                     (list 'obj853
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defconstant-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defconstant body))
                                  (list (quote :tag) 'tag852
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj853)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag852)
                          'obj853)))))
         (list (cons 'defconstant body)))))
```

<a id="function-adp-github-defgeneric"></a>
#### Macro: defgeneric

```common-lisp
(defmacro adpgh:defgeneric (&body body)
  "Add a defgeneric declaration. The macro expands to cl:defgeneric. Also, the generic function name is used to create a function-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag856
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':function)))
                    (list
                     (list 'obj857
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defgeneric-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defgeneric body))
                                  (list (quote :tag) 'tag856
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj857)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag856)
                          'obj857)))))
         (list (cons 'defgeneric body)))))
```

<a id="function-adp-github-define-compiler-macro"></a>
#### Macro: define\-compiler\-macro

```common-lisp
(defmacro adpgh:define-compiler-macro (&body body)
  "Add a define-compiler-macro declaration. The macro expands to cl:define-compiler-macro."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append nil
                           (list
                            (list 'obj861
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:define-compiler-macro-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'define-compiler-macro
                                                     body))
                                         nil))))
                   (list (quote adp:add-element) 'obj861) nil)))
         (list (cons 'define-compiler-macro body)))))
```

<a id="function-adp-github-define-condition"></a>
#### Macro: define\-condition

```common-lisp
(defmacro adpgh:define-condition (&body body)
  "Add a define-condition declaration. The macro expands to cl:define-condition. Also, the condition name is used to create a type-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag864
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':type)))
                    (list
                     (list 'obj865
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:define-condition-definition)
                                  (quote :expression)
                                  (list (quote quote)
                                        (cons 'define-condition body))
                                  (list (quote :tag) 'tag864
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj865)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag864)
                          'obj865)))))
         (list (cons 'define-condition body)))))
```

<a id="function-adp-github-define-method-combination"></a>
#### Macro: define\-method\-combination

```common-lisp
(defmacro adpgh:define-method-combination (&body body)
  "Add a define-method-combination declaration. The macro expands to cl:define-method-combination."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append nil
                           (list
                            (list 'obj869
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:define-method-combination-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'define-method-combination
                                                     body))
                                         nil))))
                   (list (quote adp:add-element) 'obj869) nil)))
         (list (cons 'define-method-combination body)))))
```

<a id="function-adp-github-define-modify-macro"></a>
#### Macro: define\-modify\-macro

```common-lisp
(defmacro adpgh:define-modify-macro (&body body)
  "Add a define-modify-macro declaration. The macro expands to cl:define-modify-macro. Also, the macro name is used to create a function-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag872
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':function)))
                    (list
                     (list 'obj873
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:define-modify-macro-definition)
                                  (quote :expression)
                                  (list (quote quote)
                                        (cons 'define-modify-macro body))
                                  (list (quote :tag) 'tag872
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj873)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag872)
                          'obj873)))))
         (list (cons 'define-modify-macro body)))))
```

<a id="function-adp-github-define-setf-expander"></a>
#### Macro: define\-setf\-expander

```common-lisp
(defmacro adpgh:define-setf-expander (&body body)
  "Add a define-setf-expander declaration. The macro expands to cl:define-setf-expander."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append nil
                           (list
                            (list 'obj877
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:define-setf-expander-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'define-setf-expander
                                                     body))
                                         nil))))
                   (list (quote adp:add-element) 'obj877) nil)))
         (list (cons 'define-setf-expander body)))))
```

<a id="function-adp-github-define-symbol-macro"></a>
#### Macro: define\-symbol\-macro

```common-lisp
(defmacro adpgh:define-symbol-macro (&body body)
  "Add a define-symbol-macro declaration. The macro expands to cl:define-symbol-macro. Also, the symbol name is used to create a symbol-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag880
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':variable)))
                    (list
                     (list 'obj881
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:define-symbol-macro-definition)
                                  (quote :expression)
                                  (list (quote quote)
                                        (cons 'define-symbol-macro body))
                                  (list (quote :tag) 'tag880
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj881)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag880)
                          'obj881)))))
         (list (cons 'define-symbol-macro body)))))
```

<a id="function-adp-github-defmacro"></a>
#### Macro: defmacro

```common-lisp
(defmacro adpgh:defmacro (&body body)
  "Add a defmacro declaration. The macro expands to cl:defmacro. Also, the macro name is used to create a function-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag884
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':function)))
                    (list
                     (list 'obj885
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defmacro-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defmacro body))
                                  (list (quote :tag) 'tag884
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj885)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag884)
                          'obj885)))))
         (list (cons 'defmacro body)))))
```

<a id="function-adp-github-defmethod"></a>
#### Macro: defmethod

```common-lisp
(defmacro adpgh:defmethod (&body body)
  "Add a defmethod declaration. The macro expands to cl:defmethod."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append nil
                           (list
                            (list 'obj889
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:defmethod-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'defmethod body))
                                         nil))))
                   (list (quote adp:add-element) 'obj889) nil)))
         (list (cons 'defmethod body)))))
```

<a id="function-adp-github-defpackage"></a>
#### Macro: defpackage

```common-lisp
(defmacro adpgh:defpackage (&body body)
  "Add a defpackage declaration. The macro expands to cl:defpackage."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append nil
                           (list
                            (list 'obj893
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:defpackage-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'defpackage body))
                                         nil))))
                   (list (quote adp:add-element) 'obj893) nil)))
         (list (cons 'defpackage body)))))
```

<a id="function-adp-github-defparameter"></a>
#### Macro: defparameter

```common-lisp
(defmacro adpgh:defparameter (&body body)
  "Add a defparameter declaration. The macro expands to cl:defparameter. Also, the parameter name is used to create a symbol-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag896
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':variable)))
                    (list
                     (list 'obj897
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defparameter-definition)
                                  (quote :expression)
                                  (list (quote quote)
                                        (cons 'defparameter body))
                                  (list (quote :tag) 'tag896
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj897)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag896)
                          'obj897)))))
         (list (cons 'defparameter body)))))
```

<a id="function-adp-github-defsetf"></a>
#### Macro: defsetf

```common-lisp
(defmacro adpgh:defsetf (&body body)
  "Add a defsetf declaration. The macro expands to cl:defsetf."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append nil
                           (list
                            (list 'obj901
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:defsetf-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'defsetf body))
                                         nil))))
                   (list (quote adp:add-element) 'obj901) nil)))
         (list (cons 'defsetf body)))))
```

<a id="function-adp-github-defstruct"></a>
#### Macro: defstruct

```common-lisp
(defmacro adpgh:defstruct (&body body)
  "Add a defstruct declaration. The macro expands to cl:defstruct. Also, the struct name is used to create a type-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag904
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':type)))
                    (list
                     (list 'obj905
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defstruct-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defstruct body))
                                  (list (quote :tag) 'tag904
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj905)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag904)
                          'obj905)))))
         (list (cons 'defstruct body)))))
```

<a id="function-adp-github-deftype"></a>
#### Macro: deftype

```common-lisp
(defmacro adpgh:deftype (&body body)
  "Add a deftype declaration. The macro expands to cl:deftype. Also, the type name is used to create a type-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag908
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':type)))
                    (list
                     (list 'obj909
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:deftype-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'deftype body))
                                  (list (quote :tag) 'tag908
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj909)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag908)
                          'obj909)))))
         (list (cons 'deftype body)))))
```

<a id="function-adp-github-defun"></a>
#### Macro: defun

```common-lisp
(defmacro adpgh:defun (&body body)
  "Add a defun declaration. The macro expands to cl:defun. Also, the function name is used to create a function-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag912
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote)
                                       (if (symbolp (car body))
                                           (car body)
                                           nil))
                                 ':function)))
                    (list
                     (list 'obj913
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defun-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defun body))
                                  (list (quote :tag) 'tag912
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj913)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag912)
                          'obj913)))))
         (list (cons 'defun body)))))
```

<a id="function-adp-github-defvar"></a>
#### Macro: defvar

```common-lisp
(defmacro adpgh:defvar (&body body)
  "Add a defvar declaration. The macro expands to cl:defvar. Also, the variable name is used to create a symbol-tag."
  (cons (quote progn)
        (append
         (when adp:*adp*
           (list
            (list* (quote let*)
                   (append
                    (list
                     (list 'tag916
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':variable)))
                    (list
                     (list 'obj917
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defvar-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defvar body))
                                  (list (quote :tag) 'tag916
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj917)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag916)
                          'obj917)))))
         (list (cons 'defvar body)))))
```

