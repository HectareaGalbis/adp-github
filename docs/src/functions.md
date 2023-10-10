<h1 id="HEADER:ADP-GITHUB:HEADERTAG772"></h1><h1 id="HEADER:ADP-GITHUB:HEADERTAG772">Reference</h1>

This is the list of functions and macros defined by ``` ADP-GITHUB ```. Almost all these functions can be used in both lisp and text mode. However, the last macros that define things, must only be used in lisp mode.

<h3 id="HEADER:ADP-GITHUB:HEADERTAG773"></h3><h3 id="HEADER:ADP-GITHUB:HEADERTAG773">Lisp and text mode functions</h3>

<h4 id="FUNCTION:ADP-GITHUB-CORE:HEADER">Macro: HEADER</h4>

```common-lisp
(DEFMACRO ADPGH-CORE:HEADER (&REST ARGS)
  (LIST (QUOTE LET*)
        (LIST
         (LIST 'TAG774
               (LIST (QUOTE GET-KEYWORD-PARAMETER) (QUOTE :TAG)
                     (LIST (QUOTE QUOTE) ARGS)))
         (LIST 'FIXED-TAG-SYM775
               (LIST (QUOTE OR) 'TAG774 (QUOTE (MAKE-UNIQUE-TAG))))
         (LIST 'TAG-OBJ776
               (LIST (QUOTE ADPGH-CORE:MAKE-TAG) 'FIXED-TAG-SYM775
                     (QUOTE :HEADER)))
         (LIST 'HEADER-OBJ777
               (LIST (QUOTE MAKE-INSTANCE)
                     (LIST (QUOTE QUOTE) 'ADPGH-CORE:HEADER) (QUOTE :ELEMENTS)
                     (LIST (QUOTE REMOVE-KEYWORD-PARAMETERS)
                           (LIST (QUOTE QUOTE) ARGS))
                     (QUOTE :USER-TAG-P) (LIST (QUOTE AND) 'TAG774 (QUOTE T))
                     (QUOTE :TAG) 'TAG-OBJ776 (QUOTE :TARGET-LOCATION)
                     (QUOTE
                      (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                       ADPGH-CORE:*PROCESS-FILE*)))))
        (LIST (QUOTE SETF) (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG-OBJ776)
              'HEADER-OBJ777)
        (LIST (QUOTE VALUES) 'HEADER-OBJ777)))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:SUBHEADER">Macro: SUBHEADER</h4>

```common-lisp
(DEFMACRO ADPGH-CORE:SUBHEADER (&REST ARGS)
  (LIST (QUOTE LET*)
        (LIST
         (LIST 'TAG780
               (LIST (QUOTE GET-KEYWORD-PARAMETER) (QUOTE :TAG)
                     (LIST (QUOTE QUOTE) ARGS)))
         (LIST 'FIXED-TAG-SYM781
               (LIST (QUOTE OR) 'TAG780 (QUOTE (MAKE-UNIQUE-TAG))))
         (LIST 'TAG-OBJ782
               (LIST (QUOTE ADPGH-CORE:MAKE-TAG) 'FIXED-TAG-SYM781
                     (QUOTE :HEADER)))
         (LIST 'HEADER-OBJ783
               (LIST (QUOTE MAKE-INSTANCE)
                     (LIST (QUOTE QUOTE) 'ADPGH-CORE:SUBHEADER)
                     (QUOTE :ELEMENTS)
                     (LIST (QUOTE REMOVE-KEYWORD-PARAMETERS)
                           (LIST (QUOTE QUOTE) ARGS))
                     (QUOTE :USER-TAG-P) (LIST (QUOTE AND) 'TAG780 (QUOTE T))
                     (QUOTE :TAG) 'TAG-OBJ782 (QUOTE :TARGET-LOCATION)
                     (QUOTE
                      (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                       ADPGH-CORE:*PROCESS-FILE*)))))
        (LIST (QUOTE SETF) (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG-OBJ782)
              'HEADER-OBJ783)
        (LIST (QUOTE VALUES) 'HEADER-OBJ783)))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:SUBSUBHEADER">Macro: SUBSUBHEADER</h4>

```common-lisp
(DEFMACRO ADPGH-CORE:SUBSUBHEADER (&REST ARGS)
  (LIST (QUOTE LET*)
        (LIST
         (LIST 'TAG786
               (LIST (QUOTE GET-KEYWORD-PARAMETER) (QUOTE :TAG)
                     (LIST (QUOTE QUOTE) ARGS)))
         (LIST 'FIXED-TAG-SYM787
               (LIST (QUOTE OR) 'TAG786 (QUOTE (MAKE-UNIQUE-TAG))))
         (LIST 'TAG-OBJ788
               (LIST (QUOTE ADPGH-CORE:MAKE-TAG) 'FIXED-TAG-SYM787
                     (QUOTE :HEADER)))
         (LIST 'HEADER-OBJ789
               (LIST (QUOTE MAKE-INSTANCE)
                     (LIST (QUOTE QUOTE) 'ADPGH-CORE:SUBSUBHEADER)
                     (QUOTE :ELEMENTS)
                     (LIST (QUOTE REMOVE-KEYWORD-PARAMETERS)
                           (LIST (QUOTE QUOTE) ARGS))
                     (QUOTE :USER-TAG-P) (LIST (QUOTE AND) 'TAG786 (QUOTE T))
                     (QUOTE :TAG) 'TAG-OBJ788 (QUOTE :TARGET-LOCATION)
                     (QUOTE
                      (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                       ADPGH-CORE:*PROCESS-FILE*)))))
        (LIST (QUOTE SETF) (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG-OBJ788)
              'HEADER-OBJ789)
        (LIST (QUOTE VALUES) 'HEADER-OBJ789)))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:TEXT">Function: TEXT</h4>

```common-lisp
(DEFUN ADPGH-CORE:TEXT (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:TEXT :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB:HREF">Macro: HREF</h4>

```common-lisp
(DEFMACRO ADPGH:HREF (SYM)
  (LIST (QUOTE MAKE-INSTANCE) (LIST (QUOTE QUOTE) 'ADPGH-CORE:HEADER-REFERENCE)
        (QUOTE :TAG)
        (LIST (QUOTE ADPGH-CORE:MAKE-TAG) (LIST (QUOTE QUOTE) SYM) ':HEADER)))
```

<h4 id="FUNCTION:ADP-GITHUB:FREF">Macro: FREF</h4>

```common-lisp
(DEFMACRO ADPGH:FREF (SYM)
  (LIST (QUOTE MAKE-INSTANCE)
        (LIST (QUOTE QUOTE) 'ADPGH-CORE:FUNCTION-REFERENCE) (QUOTE :TAG)
        (LIST (QUOTE ADPGH-CORE:MAKE-TAG) (LIST (QUOTE QUOTE) SYM) ':FUNCTION)))
```

<h4 id="FUNCTION:ADP-GITHUB:VREF">Macro: VREF</h4>

```common-lisp
(DEFMACRO ADPGH:VREF (SYM)
  (LIST (QUOTE MAKE-INSTANCE)
        (LIST (QUOTE QUOTE) 'ADPGH-CORE:VARIABLE-REFERENCE) (QUOTE :TAG)
        (LIST (QUOTE ADPGH-CORE:MAKE-TAG) (LIST (QUOTE QUOTE) SYM) ':VARIABLE)))
```

<h4 id="FUNCTION:ADP-GITHUB:TREF">Macro: TREF</h4>

```common-lisp
(DEFMACRO ADPGH:TREF (SYM)
  (LIST (QUOTE MAKE-INSTANCE) (LIST (QUOTE QUOTE) 'ADPGH-CORE:TYPE-REFERENCE)
        (QUOTE :TAG)
        (LIST (QUOTE ADPGH-CORE:MAKE-TAG) (LIST (QUOTE QUOTE) SYM) ':TYPE)))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:CELL">Function: CELL</h4>

```common-lisp
(DEFUN ADPGH-CORE:CELL (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:CELL :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:ROW">Function: ROW</h4>

```common-lisp
(DEFUN ADPGH-CORE:ROW (&REST ELEMENTS)
  (LOOP FOR ELEMENT IN ELEMENTS
        WHEN (NOT (TYPEP ELEMENT 'ADPGH-CORE:CELL))
        DO (ERROR "Each element of a row must be a cell."))
  (MAKE-INSTANCE 'ADPGH-CORE:ROW :CELLS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:TABLE">Function: TABLE</h4>

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

<h4 id="FUNCTION:ADP-GITHUB-CORE:ITEM">Function: ITEM</h4>

```common-lisp
(DEFUN ADPGH-CORE:ITEM (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:ITEM :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:ITEMIZE">Function: ITEMIZE</h4>

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

<h4 id="FUNCTION:ADP-GITHUB-CORE:ENUMERATE">Function: ENUMERATE</h4>

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

<h4 id="FUNCTION:ADP-GITHUB-CORE:TABLE-OF-CONTENTS">Function: TABLE-OF-CONTENTS</h4>

```common-lisp
(DEFUN ADPGH-CORE:TABLE-OF-CONTENTS ()
  (MAKE-INSTANCE 'ADPGH-CORE:TABLE-OF-CONTENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:MINI-TABLE-OF-CONTENTS">Function: MINI-TABLE-OF-CONTENTS</h4>

```common-lisp
(DEFUN ADPGH-CORE:MINI-TABLE-OF-CONTENTS ()
  (MAKE-INSTANCE 'ADPGH-CORE:MINI-TABLE-OF-CONTENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:TABLE-OF-FUNCTIONS">Function: TABLE-OF-FUNCTIONS</h4>

```common-lisp
(DEFUN ADPGH-CORE:TABLE-OF-FUNCTIONS ()
  (MAKE-INSTANCE 'ADPGH-CORE:TABLE-OF-FUNCTIONS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:TABLE-OF-SYMBOLS">Function: TABLE-OF-SYMBOLS</h4>

```common-lisp
(DEFUN ADPGH-CORE:TABLE-OF-SYMBOLS ()
  (MAKE-INSTANCE 'ADPGH-CORE:TABLE-OF-SYMBOLS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:TABLE-OF-TYPES">Function: TABLE-OF-TYPES</h4>

```common-lisp
(DEFUN ADPGH-CORE:TABLE-OF-TYPES () (MAKE-INSTANCE 'ADPGH-CORE:TABLE-OF-TYPES))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:IMAGE">Function: IMAGE</h4>

```common-lisp
(DEFUN ADPGH-CORE:IMAGE (PATH &KEY (ALT-TEXT "Image") (SCALE 1.0))
  (MAKE-INSTANCE 'ADPGH-CORE:IMAGE :PATH PATH :ALT-TEXT ALT-TEXT :SCALE SCALE))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:BOLD">Function: BOLD</h4>

```common-lisp
(DEFUN ADPGH-CORE:BOLD (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:BOLD :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:ITALIC">Function: ITALIC</h4>

```common-lisp
(DEFUN ADPGH-CORE:ITALIC (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:ITALIC :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:EMPHASIS">Function: EMPHASIS</h4>

```common-lisp
(DEFUN ADPGH-CORE:EMPHASIS (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:EMPHASIS :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB:INLINE">Function: INLINE</h4>

```common-lisp
(DEFUN ADPGH:INLINE (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:INLINE-CODE :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:LINK">Function: LINK</h4>

```common-lisp
(DEFUN ADPGH-CORE:LINK (NAME ADDRESS)
  (MAKE-INSTANCE 'ADPGH-CORE:LINK :NAME NAME :ADDRESS ADDRESS))
```

<h4 id="FUNCTION:ADP-GITHUB:QUOTE">Function: QUOTE</h4>

```common-lisp
(DEFUN ADPGH:QUOTE (&REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:QUOTED :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:CODE-BLOCK">Macro: CODE-BLOCK</h4>

```common-lisp
(DEFMACRO ADPGH-CORE:CODE-BLOCK (&REST EXPRESSIONS)
  (LIST (QUOTE MAKE-INSTANCE) (QUOTE 'ADPGH-CORE:CODE-BLOCK)
        (QUOTE :EXPRESSIONS) (LIST (QUOTE QUOTE) EXPRESSIONS)))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:VERBATIM-CODE-BLOCK">Function: VERBATIM-CODE-BLOCK</h4>

```common-lisp
(DEFUN ADPGH-CORE:VERBATIM-CODE-BLOCK (LANG &REST ELEMENTS)
  (MAKE-INSTANCE 'ADPGH-CORE:VERBATIM-CODE-BLOCK :LANG LANG :ELEMENTS ELEMENTS))
```

<h4 id="FUNCTION:ADP-GITHUB-CORE:EXAMPLE">Macro: EXAMPLE</h4>

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

<h3 id="HEADER:ADP-GITHUB:HEADERTAG844"></h3><h3 id="HEADER:ADP-GITHUB:HEADERTAG844">Only lisp mode functions</h3>

<h4 id="FUNCTION:ADP-GITHUB:DEFCLASS">Macro: DEFCLASS</h4>

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
                     (LIST 'TAG845
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':TYPE)))
                    (LIST
                     (LIST 'OBJ846
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFCLASS-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFCLASS BODY))
                                  (LIST (QUOTE :TAG) 'TAG845
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ846)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG845)
                          'OBJ846)))))
         (LIST (CONS 'DEFCLASS BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFCONSTANT">Macro: DEFCONSTANT</h4>

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
                     (LIST 'TAG849
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':VARIABLE)))
                    (LIST
                     (LIST 'OBJ850
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFCONSTANT-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFCONSTANT BODY))
                                  (LIST (QUOTE :TAG) 'TAG849
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ850)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG849)
                          'OBJ850)))))
         (LIST (CONS 'DEFCONSTANT BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFGENERIC">Macro: DEFGENERIC</h4>

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
                     (LIST 'TAG853
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':FUNCTION)))
                    (LIST
                     (LIST 'OBJ854
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFGENERIC-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFGENERIC BODY))
                                  (LIST (QUOTE :TAG) 'TAG853
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ854)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG853)
                          'OBJ854)))))
         (LIST (CONS 'DEFGENERIC BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFINE-COMPILER-MACRO">Macro: DEFINE-COMPILER-MACRO</h4>

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
                            (LIST 'OBJ858
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFINE-COMPILER-MACRO-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFINE-COMPILER-MACRO
                                                     BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ858) NIL)))
         (LIST (CONS 'DEFINE-COMPILER-MACRO BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFINE-CONDITION">Macro: DEFINE-CONDITION</h4>

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
                     (LIST 'TAG861
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':TYPE)))
                    (LIST
                     (LIST 'OBJ862
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFINE-CONDITION-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE)
                                        (CONS 'DEFINE-CONDITION BODY))
                                  (LIST (QUOTE :TAG) 'TAG861
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ862)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG861)
                          'OBJ862)))))
         (LIST (CONS 'DEFINE-CONDITION BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFINE-METHOD-COMBINATION">Macro: DEFINE-METHOD-COMBINATION</h4>

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
                            (LIST 'OBJ866
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFINE-METHOD-COMBINATION-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFINE-METHOD-COMBINATION
                                                     BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ866) NIL)))
         (LIST (CONS 'DEFINE-METHOD-COMBINATION BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFINE-MODIFY-MACRO">Macro: DEFINE-MODIFY-MACRO</h4>

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
                     (LIST 'TAG869
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':FUNCTION)))
                    (LIST
                     (LIST 'OBJ870
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFINE-MODIFY-MACRO-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE)
                                        (CONS 'DEFINE-MODIFY-MACRO BODY))
                                  (LIST (QUOTE :TAG) 'TAG869
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ870)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG869)
                          'OBJ870)))))
         (LIST (CONS 'DEFINE-MODIFY-MACRO BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFINE-SETF-EXPANDER">Macro: DEFINE-SETF-EXPANDER</h4>

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
                            (LIST 'OBJ874
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFINE-SETF-EXPANDER-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFINE-SETF-EXPANDER
                                                     BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ874) NIL)))
         (LIST (CONS 'DEFINE-SETF-EXPANDER BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFINE-SYMBOL-MACRO">Macro: DEFINE-SYMBOL-MACRO</h4>

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
                     (LIST 'TAG877
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':VARIABLE)))
                    (LIST
                     (LIST 'OBJ878
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFINE-SYMBOL-MACRO-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE)
                                        (CONS 'DEFINE-SYMBOL-MACRO BODY))
                                  (LIST (QUOTE :TAG) 'TAG877
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ878)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG877)
                          'OBJ878)))))
         (LIST (CONS 'DEFINE-SYMBOL-MACRO BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFMACRO">Macro: DEFMACRO</h4>

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
                     (LIST 'TAG881
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':FUNCTION)))
                    (LIST
                     (LIST 'OBJ882
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFMACRO-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFMACRO BODY))
                                  (LIST (QUOTE :TAG) 'TAG881
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ882)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG881)
                          'OBJ882)))))
         (LIST (CONS 'DEFMACRO BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFMETHOD">Macro: DEFMETHOD</h4>

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
                            (LIST 'OBJ886
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFMETHOD-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFMETHOD BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ886) NIL)))
         (LIST (CONS 'DEFMETHOD BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFPACKAGE">Macro: DEFPACKAGE</h4>

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
                            (LIST 'OBJ890
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFPACKAGE-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFPACKAGE BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ890) NIL)))
         (LIST (CONS 'DEFPACKAGE BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFPARAMETER">Macro: DEFPARAMETER</h4>

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
                     (LIST 'TAG893
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':VARIABLE)))
                    (LIST
                     (LIST 'OBJ894
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFPARAMETER-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE)
                                        (CONS 'DEFPARAMETER BODY))
                                  (LIST (QUOTE :TAG) 'TAG893
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ894)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG893)
                          'OBJ894)))))
         (LIST (CONS 'DEFPARAMETER BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFSETF">Macro: DEFSETF</h4>

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
                            (LIST 'OBJ898
                                  (LIST* (QUOTE MAKE-INSTANCE)
                                         (LIST (QUOTE QUOTE)
                                               'ADPGH-CORE:DEFSETF-DEFINITION)
                                         (QUOTE :EXPRESSION)
                                         (LIST (QUOTE QUOTE)
                                               (CONS 'DEFSETF BODY))
                                         NIL))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ898) NIL)))
         (LIST (CONS 'DEFSETF BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFSTRUCT">Macro: DEFSTRUCT</h4>

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
                     (LIST 'TAG901
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':TYPE)))
                    (LIST
                     (LIST 'OBJ902
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFSTRUCT-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFSTRUCT BODY))
                                  (LIST (QUOTE :TAG) 'TAG901
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ902)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG901)
                          'OBJ902)))))
         (LIST (CONS 'DEFSTRUCT BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFTYPE">Macro: DEFTYPE</h4>

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
                     (LIST 'TAG905
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':TYPE)))
                    (LIST
                     (LIST 'OBJ906
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFTYPE-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFTYPE BODY))
                                  (LIST (QUOTE :TAG) 'TAG905
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ906)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG905)
                          'OBJ906)))))
         (LIST (CONS 'DEFTYPE BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFUN">Macro: DEFUN</h4>

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
                     (LIST 'TAG909
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE)
                                       (IF (SYMBOLP (CAR BODY))
                                           (CAR BODY)
                                           NIL))
                                 ':FUNCTION)))
                    (LIST
                     (LIST 'OBJ910
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFUN-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFUN BODY))
                                  (LIST (QUOTE :TAG) 'TAG909
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ910)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG909)
                          'OBJ910)))))
         (LIST (CONS 'DEFUN BODY)))))
```

<h4 id="FUNCTION:ADP-GITHUB:DEFVAR">Macro: DEFVAR</h4>

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
                     (LIST 'TAG913
                           (LIST (QUOTE ADPGH-CORE:MAKE-TAG)
                                 (LIST (QUOTE QUOTE) (CAR BODY)) ':VARIABLE)))
                    (LIST
                     (LIST 'OBJ914
                           (LIST* (QUOTE MAKE-INSTANCE)
                                  (LIST (QUOTE QUOTE)
                                        'ADPGH-CORE:DEFVAR-DEFINITION)
                                  (QUOTE :EXPRESSION)
                                  (LIST (QUOTE QUOTE) (CONS 'DEFVAR BODY))
                                  (LIST (QUOTE :TAG) 'TAG913
                                        (QUOTE :TARGET-LOCATION)
                                        (QUOTE
                                         (ADPGH-CORE:FILE-TARGET-RELATIVE-PATHNAME
                                          ADPGH-CORE:*PROCESS-FILE*)))))))
                   (LIST (QUOTE ADP:ADD-ELEMENT) 'OBJ914)
                   (LIST
                    (LIST (QUOTE SETF)
                          (LIST (QUOTE ADPGH-CORE:GET-TAG-VALUE) 'TAG913)
                          'OBJ914)))))
         (LIST (CONS 'DEFVAR BODY)))))
```

