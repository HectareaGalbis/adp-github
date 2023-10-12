<a id="header-adp-github-headertag775"></a>
# Reference

This is the list of functions and macros defined by ``` ADP\-GITHUB ```\. Almost all these functions can be used in both lisp and text mode\. However\, the last macros that define things\, must only be used in lisp mode\.

<a id="header-adp-github-headertag776"></a>
## Lisp and text mode functions

<a id="function-adp-github-core-header"></a>
#### Macro: HEADER

```common-lisp
(DEFMACRO ADPGH-CORE:HEADER (&REST ARGS)
  (LIST (QUOTE LET*)
        (LIST
         (LIST 'TAG777
               (LIST (QUOTE GET-KEYWORD-PARAMETER) (QUOTE :TAG)
                     (LIST (QUOTE QUOTE) ARGS)))
         (LIST 'FIXED-TAG-SYM778
               (LIST (QUOTE OR) 'TAG777 (QUOTE (MAKE-UNIQUE-TAG))))
         (LIST 'TAG-OBJ779
               (LIST (QUOTE ADPGH-CORE:MAKE-TAG) 'FIXED-TAG-SYM778
                     (QUOTE :HEADER)))
         (LIST 'HEADER-OBJ780
               (LIST (QUOTE MAKE-INSTANCE)
                     (LIST (QUOTE QUOTE) 'ADPGH-CORE:HEADER) (QUOTE :ELEMENTS)
                     (LIST (QUOTE REMOVE-KEYWORD-PARAMETERS)
                           (LIST (QUOTE QUOTE) ARGS))
                     (QUOTE :USER-TAG-P) (LIST (QUOTE AND) 'TAG777 (QUOTE T))
                     (QUOTE :TAG) 'TAG-OBJ779 (QUOTE :TARGET-LOCATION)
                     (QUOTE
                      (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                       ADPGH-CORE:*PROCESS-FILE*)))))
        (LIST (QUOTE SETF) (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG-OBJ779)
              'HEADER-OBJ780)
        (LIST (QUOTE VALUES) 'HEADER-OBJ780)))
```

<a id="function-adp-github-core-subheader"></a>
#### Macro: SUBHEADER

```common-lisp
(DEFMACRO ADPGH-CORE:SUBHEADER (&REST ARGS)
  (LIST (QUOTE LET*)
        (LIST
         (LIST 'TAG783
               (LIST (QUOTE GET-KEYWORD-PARAMETER) (QUOTE :TAG)
                     (LIST (QUOTE QUOTE) ARGS)))
         (LIST 'FIXED-TAG-SYM784
               (LIST (QUOTE OR) 'TAG783 (QUOTE (MAKE-UNIQUE-TAG))))
         (LIST 'TAG-OBJ785
               (LIST (QUOTE ADPGH-CORE:MAKE-TAG) 'FIXED-TAG-SYM784
                     (QUOTE :HEADER)))
         (LIST 'HEADER-OBJ786
               (LIST (QUOTE MAKE-INSTANCE)
                     (LIST (QUOTE QUOTE) 'ADPGH-CORE:SUBHEADER)
                     (QUOTE :ELEMENTS)
                     (LIST (QUOTE REMOVE-KEYWORD-PARAMETERS)
                           (LIST (QUOTE QUOTE) ARGS))
                     (QUOTE :USER-TAG-P) (LIST (QUOTE AND) 'TAG783 (QUOTE T))
                     (QUOTE :TAG) 'TAG-OBJ785 (QUOTE :TARGET-LOCATION)
                     (QUOTE
                      (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                       ADPGH-CORE:*PROCESS-FILE*)))))
        (LIST (QUOTE SETF) (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG-OBJ785)
              'HEADER-OBJ786)
        (LIST (QUOTE VALUES) 'HEADER-OBJ786)))
```

<a id="function-adp-github-core-subsubheader"></a>
#### Macro: SUBSUBHEADER

```common-lisp
(DEFMACRO ADPGH-CORE:SUBSUBHEADER (&REST ARGS)
  (LIST (QUOTE LET*)
        (LIST
         (LIST 'TAG789
               (LIST (QUOTE GET-KEYWORD-PARAMETER) (QUOTE :TAG)
                     (LIST (QUOTE QUOTE) ARGS)))
         (LIST 'FIXED-TAG-SYM790
               (LIST (QUOTE OR) 'TAG789 (QUOTE (MAKE-UNIQUE-TAG))))
         (LIST 'TAG-OBJ791
               (LIST (QUOTE ADPGH-CORE:MAKE-TAG) 'FIXED-TAG-SYM790
                     (QUOTE :HEADER)))
         (LIST 'HEADER-OBJ792
               (LIST (QUOTE MAKE-INSTANCE)
                     (LIST (QUOTE QUOTE) 'ADPGH-CORE:SUBSUBHEADER)
                     (QUOTE :ELEMENTS)
                     (LIST (QUOTE REMOVE-KEYWORD-PARAMETERS)
                           (LIST (QUOTE QUOTE) ARGS))
                     (QUOTE :USER-TAG-P) (LIST (QUOTE AND) 'TAG789 (QUOTE T))
                     (QUOTE :TAG) 'TAG-OBJ791 (QUOTE :TARGET-LOCATION)
                     (QUOTE
                      (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                       ADPGH-CORE:*PROCESS-FILE*)))))
        (LIST (QUOTE SETF) (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG-OBJ791)
              'HEADER-OBJ792)
        (LIST (QUOTE VALUES) 'HEADER-OBJ792)))
```

<a id="function-adp-github-core-text"></a>
#### Function: TEXT

```common-lisp
(DEFUN ADPGH-CORE:TEXT (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:TEXT :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-href"></a>
#### Macro: HREF

```common-lisp
(DEFMACRO ADPGH:HREF (SYM)
  (LIST (QUOTE MAKE-INSTANCE) (LIST (QUOTE QUOTE) 'ADPGH-CORE:HEADER-REFERENCE)
        (QUOTE :TAG)
        (LIST (QUOTE ADPGH-CORE:MAKE-TAG) (LIST (QUOTE QUOTE) SYM) ':HEADER)))
```

<a id="function-adp-github-fref"></a>
#### Macro: FREF

```common-lisp
(DEFMACRO ADPGH:FREF (SYM)
  (LIST (QUOTE MAKE-INSTANCE)
        (LIST (QUOTE QUOTE) 'ADPGH-CORE:FUNCTION-REFERENCE) (QUOTE :TAG)
        (LIST (QUOTE ADPGH-CORE:MAKE-TAG) (LIST (QUOTE QUOTE) SYM) ':FUNCTION)))
```

<a id="function-adp-github-vref"></a>
#### Macro: VREF

```common-lisp
(DEFMACRO ADPGH:VREF (SYM)
  (LIST (QUOTE MAKE-INSTANCE)
        (LIST (QUOTE QUOTE) 'ADPGH-CORE:VARIABLE-REFERENCE) (QUOTE :TAG)
        (LIST (QUOTE ADPGH-CORE:MAKE-TAG) (LIST (QUOTE QUOTE) SYM) ':VARIABLE)))
```

<a id="function-adp-github-tref"></a>
#### Macro: TREF

```common-lisp
(DEFMACRO ADPGH:TREF (SYM)
  (LIST (QUOTE MAKE-INSTANCE) (LIST (QUOTE QUOTE) 'ADPGH-CORE:TYPE-REFERENCE)
        (QUOTE :TAG)
        (LIST (QUOTE ADPGH-CORE:MAKE-TAG) (LIST (QUOTE QUOTE) SYM) ':TYPE)))
```

<a id="function-adp-github-core-cell"></a>
#### Function: CELL

```common-lisp
(DEFUN ADPGH-CORE:CELL (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:CELL :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-core-row"></a>
#### Function: ROW

```common-lisp
(DEFUN ADPGH-CORE:ROW (&REST ELEMENTS)
  (LOOP FOR ELEMENT IN ELEMENTS
        WHEN (NOT (TYPEP ELEMENT 'ADPGH-CORE:CELL))
        DO (ERROR "Each element of a row must be a cell."))
  (MAKE-INSTANCE 'ADPGH-CORE:ROW :CELLS ELEMENTS))
```

<a id="function-adp-github-core-table"></a>
#### Function: TABLE

```common-lisp
(DEFUN ADPGH-CORE:TABLE (&REST ELEMENTS)
  (ASSERT (> (LENGTH ELEMENTS) 0))
  (LET ((NUM-CELLS (LENGTH (ADPGH-CORE:ROW-CELLS (CAR ELEMENTS)))))
    (LOOP FOR ELEMENT IN ELEMENTS
          FOR ROW-NUM-CELLS = (LENGTH (ADPGH-CORE:ROW-CELLS ELEMENT))
          WHEN (NOT (EQL NUM-CELLS ROW-NUM-CELLS))
          DO (ERROR "Every row must have the same number of elements.")
          WHEN (NOT (TYPEP ELEMENT 'ADPGH-CORE:ROW))
          DO (ERROR "Each element of a table must be a row.")))
  (MAKE-INSTANCE 'ADPGH-CORE:TABLE :ROWS ELEMENTS))
```

<a id="function-adp-github-core-item"></a>
#### Function: ITEM

```common-lisp
(DEFUN ADPGH-CORE:ITEM (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:ITEM :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-core-itemize"></a>
#### Function: ITEMIZE

```common-lisp
(DEFUN ADPGH-CORE:ITEMIZE (&REST ELEMENTS)
  (LOOP FOR ELEMENT IN ELEMENTS
        WHEN (NOT
              (TYPEP ELEMENT
                     '(OR ADPGH-CORE:ITEM ADPGH-CORE:ITEMIZE
                          ADPGH-CORE:ENUMERATE)))
        DO (ERROR "Each element of a list must be an item."))
  (MAKE-INSTANCE 'ADPGH-CORE:ITEMIZE :ITEMS ELEMENTS))
```

<a id="function-adp-github-core-enumerate"></a>
#### Function: ENUMERATE

```common-lisp
(DEFUN ADPGH-CORE:ENUMERATE (&REST ELEMENTS)
  (LOOP FOR ELEMENT IN ELEMENTS
        WHEN (NOT
              (TYPEP ELEMENT
                     '(OR ADPGH-CORE:ITEM ADPGH-CORE:ITEMIZE
                          ADPGH-CORE:ENUMERATE)))
        DO (ERROR "Each element of a list must be an item."))
  (MAKE-INSTANCE 'ADPGH-CORE:ENUMERATE :ITEMS ELEMENTS))
```

<a id="function-adp-github-core-table-of-contents"></a>
#### Function: TABLE\-OF\-CONTENTS

```common-lisp
(DEFUN ADPGH-CORE:TABLE-OF-CONTENTS ()
  (MAKE-INSTANCE 'ADPGH-CORE:TABLE-OF-CONTENTS))
```

<a id="function-adp-github-core-mini-table-of-contents"></a>
#### Function: MINI\-TABLE\-OF\-CONTENTS

```common-lisp
(DEFUN ADPGH-CORE:MINI-TABLE-OF-CONTENTS ()
  (MAKE-INSTANCE 'ADPGH-CORE:MINI-TABLE-OF-CONTENTS))
```

<a id="function-adp-github-core-table-of-functions"></a>
#### Function: TABLE\-OF\-FUNCTIONS

```common-lisp
(DEFUN ADPGH-CORE:TABLE-OF-FUNCTIONS ()
  (MAKE-INSTANCE 'ADPGH-CORE:TABLE-OF-FUNCTIONS))
```

<a id="function-adp-github-core-table-of-symbols"></a>
#### Function: TABLE\-OF\-SYMBOLS

```common-lisp
(DEFUN ADPGH-CORE:TABLE-OF-SYMBOLS ()
  (MAKE-INSTANCE 'ADPGH-CORE:TABLE-OF-SYMBOLS))
```

<a id="function-adp-github-core-table-of-types"></a>
#### Function: TABLE\-OF\-TYPES

```common-lisp
(DEFUN ADPGH-CORE:TABLE-OF-TYPES () (MAKE-INSTANCE 'ADPGH-CORE:TABLE-OF-TYPES))
```

<a id="function-adp-github-core-image"></a>
#### Function: IMAGE

```common-lisp
(DEFUN ADPGH-CORE:IMAGE (PATH &KEY (ALT-TEXT "Image") (SCALE 1.0))
  (MAKE-INSTANCE 'ADPGH-CORE:IMAGE :PATH PATH :ALT-TEXT ALT-TEXT :SCALE SCALE))
```

<a id="function-adp-github-core-bold"></a>
#### Function: BOLD

```common-lisp
(DEFUN ADPGH-CORE:BOLD (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:BOLD :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-core-italic"></a>
#### Function: ITALIC

```common-lisp
(DEFUN ADPGH-CORE:ITALIC (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:ITALIC :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-core-emphasis"></a>
#### Function: EMPHASIS

```common-lisp
(DEFUN ADPGH-CORE:EMPHASIS (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:EMPHASIS :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-inline"></a>
#### Function: INLINE

```common-lisp
(DEFUN ADPGH:INLINE (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:INLINE-CODE :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-core-link"></a>
#### Function: LINK

```common-lisp
(DEFUN ADPGH-CORE:LINK (NAME ADDRESS)
  (MAKE-INSTANCE 'ADPGH-CORE:LINK :NAME NAME :ADDRESS ADDRESS))
```

<a id="function-adp-github-quote"></a>
#### Function: QUOTE

```common-lisp
(DEFUN ADPGH:QUOTE (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:QUOTED :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-core-code-block"></a>
#### Macro: CODE\-BLOCK

```common-lisp
(DEFMACRO ADPGH-CORE:CODE-BLOCK (&REST EXPRESSIONS)
  (LIST (QUOTE MAKE-INSTANCE) (QUOTE 'ADPGH-CORE:CODE-BLOCK)
        (QUOTE :EXPRESSIONS) (LIST (QUOTE QUOTE) EXPRESSIONS)))
```

<a id="function-adp-github-core-verbatim-code-block"></a>
#### Function: VERBATIM\-CODE\-BLOCK

```common-lisp
(DEFUN ADPGH-CORE:VERBATIM-CODE-BLOCK (LANG &REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:VERBATIM-CODE-BLOCK :LANG LANG :ELEMENTS ELEMENTS))
```

<a id="function-adp-github-core-example"></a>
#### Macro: EXAMPLE

```common-lisp
(DEFMACRO ADPGH-CORE:EXAMPLE (&REST EXPRESSIONS)
  (ALEXANDRIA-1:WITH-GENSYMS (OUTPUT RESULT)
    (LIST (QUOTE LET*)
          (LIST
           (LIST OUTPUT
                 (QUOTE
                  (MAKE-ARRAY 10 :ADJUSTABLE T :FILL-POINTER 0 :ELEMENT-TYPE
                              'CHARACTER)))
           (LIST RESULT
                 (LIST (QUOTE MULTIPLE-VALUE-LIST)
                       (LIST* (QUOTE WITH-OUTPUT-TO-STRING)
                              (LIST (QUOTE *STANDARD-OUTPUT*) OUTPUT)
                              EXPRESSIONS))))
          (LIST (QUOTE MAKE-INSTANCE) (QUOTE 'ADPGH-CORE:EXAMPLE)
                (QUOTE :EXPRESSIONS) (LIST (QUOTE QUOTE) EXPRESSIONS)
                (QUOTE :OUTPUT) OUTPUT (QUOTE :RESULT) RESULT))))
```

<a id="header-adp-github-headertag847"></a>
## Only lisp mode functions

<a id="function-adp-github-defclass"></a>
#### Macro: DEFCLASS

```common-lisp
(DEFMACRO ADPGH:DEFCLASS (&BODY BODY)
  "Add a defclass declaration. The macro expands to cl:defclass. Also, the class name is used to create a type-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG848
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':TYPE)))
                    (LIST
                     (LIST 'OBJ849
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFCLASS-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFCLASS BODY))
                                  (LIST (QUOTE :TAG) 'TAG848
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ849)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG848)
                          'OBJ849)))))
         (LIST (CONS 'DEFCLASS BODY)))))
```

<a id="function-adp-github-defconstant"></a>
#### Macro: DEFCONSTANT

```common-lisp
(DEFMACRO ADPGH:DEFCONSTANT (&BODY BODY)
  "Add a defconstant declaration. The macro expands to cl:defconstant. Also, the constant name is used to create a symbol-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG852
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':VARIABLE)))
                    (LIST
                     (LIST 'OBJ853
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFCONSTANT-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFCONSTANT BODY))
                                  (LIST (QUOTE :TAG) 'TAG852
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ853)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG852)
                          'OBJ853)))))
         (LIST (CONS 'DEFCONSTANT BODY)))))
```

<a id="function-adp-github-defgeneric"></a>
#### Macro: DEFGENERIC

```common-lisp
(DEFMACRO ADPGH:DEFGENERIC (&BODY BODY)
  "Add a defgeneric declaration. The macro expands to cl:defgeneric. Also, the generic function name is used to create a function-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG856
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':FUNCTION)))
                    (LIST
                     (LIST 'OBJ857
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFGENERIC-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFGENERIC BODY))
                                  (LIST (QUOTE :TAG) 'TAG856
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ857)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG856)
                          'OBJ857)))))
         (LIST (CONS 'DEFGENERIC BODY)))))
```

<a id="function-adp-github-define-compiler-macro"></a>
#### Macro: DEFINE\-COMPILER\-MACRO

```common-lisp
(DEFMACRO ADPGH:DEFINE-COMPILER-MACRO (&BODY BODY)
  "Add a define-compiler-macro declaration. The macro expands to cl:define-compiler-macro."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND NIL
                           (LIST
                            (LIST 'OBJ861
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFINE-COMPILER-MACRO-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFINE-COMPILER-MACRO
                                                     BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ861) NIL)))
         (LIST (CONS 'DEFINE-COMPILER-MACRO BODY)))))
```

<a id="function-adp-github-define-condition"></a>
#### Macro: DEFINE\-CONDITION

```common-lisp
(DEFMACRO ADPGH:DEFINE-CONDITION (&BODY BODY)
  "Add a define-condition declaration. The macro expands to cl:define-condition. Also, the condition name is used to create a type-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG864
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':TYPE)))
                    (LIST
                     (LIST 'OBJ865
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFINE-CONDITION-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE)
                                        (CONS 'DEFINE-CONDITION BODY))
                                  (LIST (QUOTE :TAG) 'TAG864
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ865)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG864)
                          'OBJ865)))))
         (LIST (CONS 'DEFINE-CONDITION BODY)))))
```

<a id="function-adp-github-define-method-combination"></a>
#### Macro: DEFINE\-METHOD\-COMBINATION

```common-lisp
(DEFMACRO ADPGH:DEFINE-METHOD-COMBINATION (&BODY BODY)
  "Add a define-method-combination declaration. The macro expands to cl:define-method-combination."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND NIL
                           (LIST
                            (LIST 'OBJ869
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFINE-METHOD-COMBINATION-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFINE-METHOD-COMBINATION
                                                     BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ869) NIL)))
         (LIST (CONS 'DEFINE-METHOD-COMBINATION BODY)))))
```

<a id="function-adp-github-define-modify-macro"></a>
#### Macro: DEFINE\-MODIFY\-MACRO

```common-lisp
(DEFMACRO ADPGH:DEFINE-MODIFY-MACRO (&BODY BODY)
  "Add a define-modify-macro declaration. The macro expands to cl:define-modify-macro. Also, the macro name is used to create a function-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG872
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':FUNCTION)))
                    (LIST
                     (LIST 'OBJ873
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFINE-MODIFY-MACRO-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE)
                                        (CONS 'DEFINE-MODIFY-MACRO BODY))
                                  (LIST (QUOTE :TAG) 'TAG872
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ873)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG872)
                          'OBJ873)))))
         (LIST (CONS 'DEFINE-MODIFY-MACRO BODY)))))
```

<a id="function-adp-github-define-setf-expander"></a>
#### Macro: DEFINE\-SETF\-EXPANDER

```common-lisp
(DEFMACRO ADPGH:DEFINE-SETF-EXPANDER (&BODY BODY)
  "Add a define-setf-expander declaration. The macro expands to cl:define-setf-expander."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND NIL
                           (LIST
                            (LIST 'OBJ877
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFINE-SETF-EXPANDER-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFINE-SETF-EXPANDER
                                                     BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ877) NIL)))
         (LIST (CONS 'DEFINE-SETF-EXPANDER BODY)))))
```

<a id="function-adp-github-define-symbol-macro"></a>
#### Macro: DEFINE\-SYMBOL\-MACRO

```common-lisp
(DEFMACRO ADPGH:DEFINE-SYMBOL-MACRO (&BODY BODY)
  "Add a define-symbol-macro declaration. The macro expands to cl:define-symbol-macro. Also, the symbol name is used to create a symbol-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG880
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':VARIABLE)))
                    (LIST
                     (LIST 'OBJ881
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFINE-SYMBOL-MACRO-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE)
                                        (CONS 'DEFINE-SYMBOL-MACRO BODY))
                                  (LIST (QUOTE :TAG) 'TAG880
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ881)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG880)
                          'OBJ881)))))
         (LIST (CONS 'DEFINE-SYMBOL-MACRO BODY)))))
```

<a id="function-adp-github-defmacro"></a>
#### Macro: DEFMACRO

```common-lisp
(DEFMACRO ADPGH:DEFMACRO (&BODY BODY)
  "Add a defmacro declaration. The macro expands to cl:defmacro. Also, the macro name is used to create a function-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG884
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':FUNCTION)))
                    (LIST
                     (LIST 'OBJ885
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFMACRO-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFMACRO BODY))
                                  (LIST (QUOTE :TAG) 'TAG884
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ885)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG884)
                          'OBJ885)))))
         (LIST (CONS 'DEFMACRO BODY)))))
```

<a id="function-adp-github-defmethod"></a>
#### Macro: DEFMETHOD

```common-lisp
(DEFMACRO ADPGH:DEFMETHOD (&BODY BODY)
  "Add a defmethod declaration. The macro expands to cl:defmethod."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND NIL
                           (LIST
                            (LIST 'OBJ889
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFMETHOD-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFMETHOD BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ889) NIL)))
         (LIST (CONS 'DEFMETHOD BODY)))))
```

<a id="function-adp-github-defpackage"></a>
#### Macro: DEFPACKAGE

```common-lisp
(DEFMACRO ADPGH:DEFPACKAGE (&BODY BODY)
  "Add a defpackage declaration. The macro expands to cl:defpackage."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND NIL
                           (LIST
                            (LIST 'OBJ893
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFPACKAGE-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFPACKAGE BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ893) NIL)))
         (LIST (CONS 'DEFPACKAGE BODY)))))
```

<a id="function-adp-github-defparameter"></a>
#### Macro: DEFPARAMETER

```common-lisp
(DEFMACRO ADPGH:DEFPARAMETER (&BODY BODY)
  "Add a defparameter declaration. The macro expands to cl:defparameter. Also, the parameter name is used to create a symbol-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG896
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':VARIABLE)))
                    (LIST
                     (LIST 'OBJ897
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFPARAMETER-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE)
                                        (CONS 'DEFPARAMETER BODY))
                                  (LIST (QUOTE :TAG) 'TAG896
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ897)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG896)
                          'OBJ897)))))
         (LIST (CONS 'DEFPARAMETER BODY)))))
```

<a id="function-adp-github-defsetf"></a>
#### Macro: DEFSETF

```common-lisp
(DEFMACRO ADPGH:DEFSETF (&BODY BODY)
  "Add a defsetf declaration. The macro expands to cl:defsetf."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND NIL
                           (LIST
                            (LIST 'OBJ901
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFSETF-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFSETF BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ901) NIL)))
         (LIST (CONS 'DEFSETF BODY)))))
```

<a id="function-adp-github-defstruct"></a>
#### Macro: DEFSTRUCT

```common-lisp
(DEFMACRO ADPGH:DEFSTRUCT (&BODY BODY)
  "Add a defstruct declaration. The macro expands to cl:defstruct. Also, the struct name is used to create a type-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG904
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':TYPE)))
                    (LIST
                     (LIST 'OBJ905
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFSTRUCT-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFSTRUCT BODY))
                                  (LIST (QUOTE :TAG) 'TAG904
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ905)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG904)
                          'OBJ905)))))
         (LIST (CONS 'DEFSTRUCT BODY)))))
```

<a id="function-adp-github-deftype"></a>
#### Macro: DEFTYPE

```common-lisp
(DEFMACRO ADPGH:DEFTYPE (&BODY BODY)
  "Add a deftype declaration. The macro expands to cl:deftype. Also, the type name is used to create a type-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG908
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':TYPE)))
                    (LIST
                     (LIST 'OBJ909
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFTYPE-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFTYPE BODY))
                                  (LIST (QUOTE :TAG) 'TAG908
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ909)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG908)
                          'OBJ909)))))
         (LIST (CONS 'DEFTYPE BODY)))))
```

<a id="function-adp-github-defun"></a>
#### Macro: DEFUN

```common-lisp
(DEFMACRO ADPGH:DEFUN (&BODY BODY)
  "Add a defun declaration. The macro expands to cl:defun. Also, the function name is used to create a function-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG912
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE)
                                       (IF (SYMBOLP (CAR BODY))
                                           (CAR BODY)
                                           NIL))
                                 ':FUNCTION)))
                    (LIST
                     (LIST 'OBJ913
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFUN-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFUN BODY))
                                  (LIST (QUOTE :TAG) 'TAG912
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ913)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG912)
                          'OBJ913)))))
         (LIST (CONS 'DEFUN BODY)))))
```

<a id="function-adp-github-defvar"></a>
#### Macro: DEFVAR

```common-lisp
(DEFMACRO ADPGH:DEFVAR (&BODY BODY)
  "Add a defvar declaration. The macro expands to cl:defvar. Also, the variable name is used to create a symbol-tag."
  (CONS (QUOTE PROGN)
        (APPEND
         (WHEN ADP:*ADP*
           (LIST
            (LIST* (QUOTE LET*)
                   (APPEND
                    (LIST
                     (LIST 'TAG916
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':VARIABLE)))
                    (LIST
                     (LIST 'OBJ917
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFVAR-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFVAR BODY))
                                  (LIST (QUOTE :TAG) 'TAG916
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ917)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG916)
                          'OBJ917)))))
         (LIST (CONS 'DEFVAR BODY)))))
```

