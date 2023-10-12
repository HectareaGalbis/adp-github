<a id="header-adp-github-reference"></a>
# Reference

This is the list of functions and macros defined by ``` ADP-GITHUB ```\. Almost all these functions can be used in both lisp and text mode\. However\, the last macros that define things\, must only be used in lisp mode\.

<a id="header-adp-github-headertag774"></a>
## Lisp and text mode functions

<a id="function-adp-github-core-header"></a>
#### Macro: header

```common-lisp
(defmacro adpgh-core:header (&rest args)
  (list (quote let*)
        (list
         (list 'tag775
               (list (quote get-keyword-parameter) (quote :tag)
                     (list (quote quote) args)))
         (list 'fixed-tag-sym776
               (list (quote or) 'tag775 (quote (make-unique-tag))))
         (list 'tag-obj777
               (list (quote adpgh-core:make-tag) 'fixed-tag-sym776
                     (quote :header)))
         (list 'header-obj778
               (list (quote make-instance)
                     (list (quote quote) 'adpgh-core:header) (quote :elements)
                     (list (quote remove-keyword-parameters)
                           (list (quote quote) args))
                     (quote :user-tag-p) (list (quote and) 'tag775 (quote t))
                     (quote :tag) 'tag-obj777 (quote :target-location)
                     (quote
                      (adpgh-core:file-target-relative-pathname
                       adpgh-core:*process-file*)))))
        (list (quote setf) (list (quote adpgh-core:get-tag-value) 'tag-obj777)
              'header-obj778)
        (list (quote values) 'header-obj778)))
```

<a id="function-adp-github-core-subheader"></a>
#### Macro: subheader

```common-lisp
(defmacro adpgh-core:subheader (&rest args)
  (list (quote let*)
        (list
         (list 'tag781
               (list (quote get-keyword-parameter) (quote :tag)
                     (list (quote quote) args)))
         (list 'fixed-tag-sym782
               (list (quote or) 'tag781 (quote (make-unique-tag))))
         (list 'tag-obj783
               (list (quote adpgh-core:make-tag) 'fixed-tag-sym782
                     (quote :header)))
         (list 'header-obj784
               (list (quote make-instance)
                     (list (quote quote) 'adpgh-core:subheader)
                     (quote :elements)
                     (list (quote remove-keyword-parameters)
                           (list (quote quote) args))
                     (quote :user-tag-p) (list (quote and) 'tag781 (quote t))
                     (quote :tag) 'tag-obj783 (quote :target-location)
                     (quote
                      (adpgh-core:file-target-relative-pathname
                       adpgh-core:*process-file*)))))
        (list (quote setf) (list (quote adpgh-core:get-tag-value) 'tag-obj783)
              'header-obj784)
        (list (quote values) 'header-obj784)))
```

<a id="function-adp-github-core-subsubheader"></a>
#### Macro: subsubheader

```common-lisp
(defmacro adpgh-core:subsubheader (&rest args)
  (list (quote let*)
        (list
         (list 'tag787
               (list (quote get-keyword-parameter) (quote :tag)
                     (list (quote quote) args)))
         (list 'fixed-tag-sym788
               (list (quote or) 'tag787 (quote (make-unique-tag))))
         (list 'tag-obj789
               (list (quote adpgh-core:make-tag) 'fixed-tag-sym788
                     (quote :header)))
         (list 'header-obj790
               (list (quote make-instance)
                     (list (quote quote) 'adpgh-core:subsubheader)
                     (quote :elements)
                     (list (quote remove-keyword-parameters)
                           (list (quote quote) args))
                     (quote :user-tag-p) (list (quote and) 'tag787 (quote t))
                     (quote :tag) 'tag-obj789 (quote :target-location)
                     (quote
                      (adpgh-core:file-target-relative-pathname
                       adpgh-core:*process-file*)))))
        (list (quote setf) (list (quote adpgh-core:get-tag-value) 'tag-obj789)
              'header-obj790)
        (list (quote values) 'header-obj790)))
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
(defun adpgh-core:verbatim-code-block (&rest elements)
  (with-key-params ((lang) rest-elements elements)
    (make-instance 'adpgh-core:verbatim-code-block :lang lang :elements
                   rest-elements)))
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

<a id="header-adp-github-headertag845"></a>
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
                     (list 'tag846
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':type)))
                    (list
                     (list 'obj847
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defclass-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defclass body))
                                  (list (quote :tag) 'tag846
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj847)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag846)
                          'obj847)))))
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
                     (list 'tag850
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':variable)))
                    (list
                     (list 'obj851
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defconstant-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defconstant body))
                                  (list (quote :tag) 'tag850
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj851)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag850)
                          'obj851)))))
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
                     (list 'tag854
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':function)))
                    (list
                     (list 'obj855
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defgeneric-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defgeneric body))
                                  (list (quote :tag) 'tag854
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj855)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag854)
                          'obj855)))))
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
                            (list 'obj859
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:define-compiler-macro-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'define-compiler-macro
                                                     body))
                                         nil))))
                   (list (quote adp:add-element) 'obj859) nil)))
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
                     (list 'tag862
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':type)))
                    (list
                     (list 'obj863
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:define-condition-definition)
                                  (quote :expression)
                                  (list (quote quote)
                                        (cons 'define-condition body))
                                  (list (quote :tag) 'tag862
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj863)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag862)
                          'obj863)))))
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
                            (list 'obj867
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:define-method-combination-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'define-method-combination
                                                     body))
                                         nil))))
                   (list (quote adp:add-element) 'obj867) nil)))
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
                     (list 'tag870
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':function)))
                    (list
                     (list 'obj871
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:define-modify-macro-definition)
                                  (quote :expression)
                                  (list (quote quote)
                                        (cons 'define-modify-macro body))
                                  (list (quote :tag) 'tag870
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj871)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag870)
                          'obj871)))))
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
                            (list 'obj875
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:define-setf-expander-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'define-setf-expander
                                                     body))
                                         nil))))
                   (list (quote adp:add-element) 'obj875) nil)))
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
                     (list 'tag878
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':variable)))
                    (list
                     (list 'obj879
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:define-symbol-macro-definition)
                                  (quote :expression)
                                  (list (quote quote)
                                        (cons 'define-symbol-macro body))
                                  (list (quote :tag) 'tag878
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj879)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag878)
                          'obj879)))))
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
                     (list 'tag882
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':function)))
                    (list
                     (list 'obj883
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defmacro-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defmacro body))
                                  (list (quote :tag) 'tag882
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj883)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag882)
                          'obj883)))))
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
                            (list 'obj887
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:defmethod-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'defmethod body))
                                         nil))))
                   (list (quote adp:add-element) 'obj887) nil)))
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
                            (list 'obj891
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:defpackage-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'defpackage body))
                                         nil))))
                   (list (quote adp:add-element) 'obj891) nil)))
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
                     (list 'tag894
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':variable)))
                    (list
                     (list 'obj895
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defparameter-definition)
                                  (quote :expression)
                                  (list (quote quote)
                                        (cons 'defparameter body))
                                  (list (quote :tag) 'tag894
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj895)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag894)
                          'obj895)))))
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
                            (list 'obj899
                                  (list* (quote make-instance)
                                         (list (quote quote)
                                               'adpgh-core:defsetf-definition)
                                         (quote :expression)
                                         (list (quote quote)
                                               (cons 'defsetf body))
                                         nil))))
                   (list (quote adp:add-element) 'obj899) nil)))
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
                     (list 'tag902
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':type)))
                    (list
                     (list 'obj903
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defstruct-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defstruct body))
                                  (list (quote :tag) 'tag902
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj903)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag902)
                          'obj903)))))
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
                     (list 'tag906
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':type)))
                    (list
                     (list 'obj907
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:deftype-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'deftype body))
                                  (list (quote :tag) 'tag906
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj907)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag906)
                          'obj907)))))
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
                     (list 'tag910
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote)
                                       (if (symbolp (car body))
                                           (car body)
                                           nil))
                                 ':function)))
                    (list
                     (list 'obj911
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defun-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defun body))
                                  (list (quote :tag) 'tag910
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj911)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag910)
                          'obj911)))))
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
                     (list 'tag914
                           (list (quote adpgh-core:make-tag)
                                 (list (quote quote) (car body)) ':variable)))
                    (list
                     (list 'obj915
                           (list* (quote make-instance)
                                  (list (quote quote)
                                        'adpgh-core:defvar-definition)
                                  (quote :expression)
                                  (list (quote quote) (cons 'defvar body))
                                  (list (quote :tag) 'tag914
                                        (quote :target-location)
                                        (quote
                                         (adpgh-core:file-target-relative-pathname
                                          adpgh-core:*process-file*)))))))
                   (list (quote adp:add-element) 'obj915)
                   (list
                    (list (quote setf)
                          (list (quote adpgh-core:get-tag-value) 'tag914)
                          'obj915)))))
         (list (cons 'defvar body)))))
```

