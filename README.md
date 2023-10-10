# Add Documentation\, Please\.\.\. with Github Flavoured Markdown

Welcome to ADP\-GITHUB\!

``` ADP\-GITHUB ``` is an extension for ``` ADP ```\. It exports some functions and macros to print markdown\-styled objects like headers\, lists\, code blocks and more\. It also supports cross references and table of contents\. Every symbol is exported from the ``` adp\-github ``` package\, although you can use the nickname ``` adpgh ```\.

* <a href="/docs/src/functions.md#reference">Reference</a>
  * <a href="/docs/src/functions.md#lisp-and-text-mode-functions">Lisp and text mode functions</a>
  * <a href="/docs/src/functions.md#only-lisp-mode-functions">Only lisp mode functions</a>
* <a href="/README.md#add-documentation-please-with-github-flavoured-markdown">Add Documentation\, Please\.\.\. with Github Flavoured Markdown</a>


* V
  * <a href="/docs/src/functions.md#function-adp-github-vref">ADP-GITHUB:VREF</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-verbatim-code-block">ADP-GITHUB-CORE:VERBATIM-CODE-BLOCK</a>
* T
  * <a href="/docs/src/functions.md#function-adp-github-tref">ADP-GITHUB:TREF</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-text">ADP-GITHUB-CORE:TEXT</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-table-of-types">ADP-GITHUB-CORE:TABLE-OF-TYPES</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-table-of-symbols">ADP-GITHUB-CORE:TABLE-OF-SYMBOLS</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-table-of-functions">ADP-GITHUB-CORE:TABLE-OF-FUNCTIONS</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-table-of-contents">ADP-GITHUB-CORE:TABLE-OF-CONTENTS</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-table">ADP-GITHUB-CORE:TABLE</a>
* S
  * <a href="/docs/src/functions.md#function-adp-github-core-subsubheader">ADP-GITHUB-CORE:SUBSUBHEADER</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-subheader">ADP-GITHUB-CORE:SUBHEADER</a>
* R
  * <a href="/docs/src/functions.md#function-adp-github-core-row">ADP-GITHUB-CORE:ROW</a>
* Q
  * <a href="/docs/src/functions.md#function-adp-github-quote">ADP-GITHUB:QUOTE</a>
* M
  * <a href="/docs/src/functions.md#function-adp-github-core-mini-table-of-contents">ADP-GITHUB-CORE:MINI-TABLE-OF-CONTENTS</a>
* L
  * <a href="/docs/src/functions.md#function-adp-github-core-link">ADP-GITHUB-CORE:LINK</a>
* I
  * <a href="/docs/src/functions.md#function-adp-github-core-itemize">ADP-GITHUB-CORE:ITEMIZE</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-item">ADP-GITHUB-CORE:ITEM</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-italic">ADP-GITHUB-CORE:ITALIC</a>
  * <a href="/docs/src/functions.md#function-adp-github-inline">ADP-GITHUB:INLINE</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-image">ADP-GITHUB-CORE:IMAGE</a>
* H
  * <a href="/docs/src/functions.md#function-adp-github-href">ADP-GITHUB:HREF</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-header">ADP-GITHUB-CORE:HEADER</a>
* F
  * <a href="/docs/src/functions.md#function-adp-github-fref">ADP-GITHUB:FREF</a>
* E
  * <a href="/docs/src/functions.md#function-adp-github-core-example">ADP-GITHUB-CORE:EXAMPLE</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-enumerate">ADP-GITHUB-CORE:ENUMERATE</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-emphasis">ADP-GITHUB-CORE:EMPHASIS</a>
* D
  * <a href="/docs/src/functions.md#function-adp-github-defvar">ADP-GITHUB:DEFVAR</a>
  * <a href="/docs/src/functions.md#function-adp-github-defun">ADP-GITHUB:DEFUN</a>
  * <a href="/docs/src/functions.md#function-adp-github-deftype">ADP-GITHUB:DEFTYPE</a>
  * <a href="/docs/src/functions.md#function-adp-github-defstruct">ADP-GITHUB:DEFSTRUCT</a>
  * <a href="/docs/src/functions.md#function-adp-github-defsetf">ADP-GITHUB:DEFSETF</a>
  * <a href="/docs/src/functions.md#function-adp-github-defparameter">ADP-GITHUB:DEFPARAMETER</a>
  * <a href="/docs/src/functions.md#function-adp-github-defpackage">ADP-GITHUB:DEFPACKAGE</a>
  * <a href="/docs/src/functions.md#function-adp-github-defmethod">ADP-GITHUB:DEFMETHOD</a>
  * <a href="/docs/src/functions.md#function-adp-github-defmacro">ADP-GITHUB:DEFMACRO</a>
  * <a href="/docs/src/functions.md#function-adp-github-define-symbol-macro">ADP-GITHUB:DEFINE-SYMBOL-MACRO</a>
  * <a href="/docs/src/functions.md#function-adp-github-define-setf-expander">ADP-GITHUB:DEFINE-SETF-EXPANDER</a>
  * <a href="/docs/src/functions.md#function-adp-github-define-modify-macro">ADP-GITHUB:DEFINE-MODIFY-MACRO</a>
  * <a href="/docs/src/functions.md#function-adp-github-define-method-combination">ADP-GITHUB:DEFINE-METHOD-COMBINATION</a>
  * <a href="/docs/src/functions.md#function-adp-github-define-condition">ADP-GITHUB:DEFINE-CONDITION</a>
  * <a href="/docs/src/functions.md#function-adp-github-define-compiler-macro">ADP-GITHUB:DEFINE-COMPILER-MACRO</a>
  * <a href="/docs/src/functions.md#function-adp-github-defgeneric">ADP-GITHUB:DEFGENERIC</a>
  * <a href="/docs/src/functions.md#function-adp-github-defconstant">ADP-GITHUB:DEFCONSTANT</a>
  * <a href="/docs/src/functions.md#function-adp-github-defclass">ADP-GITHUB:DEFCLASS</a>
* C
  * <a href="/docs/src/functions.md#function-adp-github-core-code-block">ADP-GITHUB-CORE:CODE-BLOCK</a>
  * <a href="/docs/src/functions.md#function-adp-github-core-cell">ADP-GITHUB-CORE:CELL</a>
* B
  * <a href="/docs/src/functions.md#function-adp-github-core-bold">ADP-GITHUB-CORE:BOLD</a>
