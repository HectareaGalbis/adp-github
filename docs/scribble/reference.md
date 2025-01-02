<a id="TITLE:ADPGH-DOCS:REFERENCE"></a>
# Reference

* [adpgh\:bold](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG8)
* [adpgh\:cell](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG1)
* [adpgh\:class\-description](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG7)
* [adpgh\:class\-glossary](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG5)
* [adpgh\:clref](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG21)
* [adpgh\:code](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG28)
* [adpgh\:code\-block](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG16)
* [adpgh\:cref](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG3)
* [adpgh\:emphasis](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG36)
* [adpgh\:enumerate](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG35)
* [adpgh\:example](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG11)
* [adpgh\:fref](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG25)
* [adpgh\:function\-description](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG27)
* [adpgh\:function\-glossary](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG19)
* [adpgh\:image](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG20)
* [adpgh\:italic](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG29)
* [adpgh\:item](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG32)
* [adpgh\:itemize](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG22)
* [adpgh\:link](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG34)
* [adpgh\:output\-file](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG40)
* [adpgh\:package\-description](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG12)
* [adpgh\:pref](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG6)
* [adpgh\:quoted](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG17)
* [adpgh\:row](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG39)
* [adpgh\:sref](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG26)
* [adpgh\:subsubtitle](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG4)
* [adpgh\:subtitle](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG31)
* [adpgh\:system\-description](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG23)
* [adpgh\:table](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG37)
* [adpgh\:table\-of\-classes](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG13)
* [adpgh\:table\-of\-contents](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG9)
* [adpgh\:table\-of\-functions](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG15)
* [adpgh\:table\-of\-variables](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG30)
* [adpgh\:text](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG38)
* [adpgh\:title](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG18)
* [adpgh\:title\*](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG2)
* [adpgh\:tref](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG14)
* [adpgh\:variable\-description](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG33)
* [adpgh\:variable\-glossary](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG24)
* [adpgh\:vref](/docs/scribble/reference.md#FUNCTION:ADPGH-DOCS:TAG10)


<a id="FUNCTION:ADP-GITHUB:BOLD"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG8"></a>
#### Function: adpgh\:bold \(\&rest elements\)

`````text
Inserts text with bold style.
`````

<a id="FUNCTION:ADP-GITHUB:CELL"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG1"></a>
#### Function: adpgh\:cell \(\&rest elements\)

`````text
Inserts a cell.

Cells can only be used inside a table row.
`````

<a id="FUNCTION:ADP-GITHUB:CLASS-DESCRIPTION"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG7"></a>
#### Macro: adpgh\:class\-description \(sym \:tag \(tag \(make\-unique\-tag\)\)\)

`````text
Inserts a class description.

It must receive the class name (a symbol, not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with cref.
The tag must be a symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:CLASS-GLOSSARY"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG5"></a>
#### Macro: adpgh\:class\-glossary \(pkg\)

`````text
Inserts a class glossary.

It will insert all the available class descriptions from the external symbols of
the given package PKG.
The argument PKG must be a package descriptor (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:CLREF"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG21"></a>
#### Macro: adpgh\:clref \(sym\)

`````text
Inserts a hyperlink to the Common Lisp Hyperspec for a given symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:CODE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG28"></a>
#### Function: adpgh\:code \(\&rest elements\)

`````text
Inserts text with code style.
`````

<a id="FUNCTION:ADP-GITHUB:CODE-BLOCK"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG16"></a>
#### Function: adpgh\:code\-block \(\:lang \(lang nil\) \&rest elements\)

`````text
Inserts a block of code.

It can receive the keyword :lang, a string that specifies the language to be used.
The rest of elements will be inserted in the block.
`````

<a id="FUNCTION:ADP-GITHUB:CREF"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG3"></a>
#### Macro: adpgh\:cref \(name \&rest text\)

`````text
Inserts a reference to a class.

NAME must be a symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:EMPHASIS"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG36"></a>
#### Function: adpgh\:emphasis \(\&rest elements\)

`````text
Inserts text with emphasis style.
`````

<a id="FUNCTION:ADP-GITHUB:ENUMERATE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG35"></a>
#### Function: adpgh\:enumerate \(\&rest elements\)

`````text
Inserts an enumerated list.

It can contains items or sublists, i.e., items, itemizes or enumerates.
`````

<a id="FUNCTION:ADP-GITHUB:EXAMPLE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG11"></a>
#### Function: adpgh\:example \(\&rest expressions\)

`````text
Inserts an example.

It is like code-block, but evaluates the code (common lisp only) and prints
its output and returned values.
`````

<a id="FUNCTION:ADP-GITHUB:FREF"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG25"></a>
#### Macro: adpgh\:fref \(name \&rest text\)

`````text
Inserts a reference to a function.

NAME must be a symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:FUNCTION-DESCRIPTION"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG27"></a>
#### Macro: adpgh\:function\-description \(name \:tag \(tag \(make\-unique\-tag\)\)\)

`````text
Inserts a function description.

It must receive the function name (a symbol, not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with fref.
The tag must be a symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:FUNCTION-GLOSSARY"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG19"></a>
#### Macro: adpgh\:function\-glossary \(pkg\)

`````text
Inserts a function glossary.

It will insert all the available function descriptions from the external symbols of
the given package PKG.
The argument PKG must be a package descriptor (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:IMAGE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG20"></a>
#### Function: adpgh\:image \(path \:alt\-text \(alt\-text Image\) \:scale \(scale 1\.0\)\)

`````text
Inserts an image.

It must receive the path to the image (relative to the project's root directory).
Optionally, it can receive an alternative text description and the scale size of the image.
`````

<a id="FUNCTION:ADP-GITHUB:ITALIC"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG29"></a>
#### Function: adpgh\:italic \(\&rest elements\)

`````text
Inserts text with italic style.
`````

<a id="FUNCTION:ADP-GITHUB:ITEM"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG32"></a>
#### Function: adpgh\:item \(\&rest elements\)

`````text
Inserts an item if it is used inside an itemize or enumerate.
`````

<a id="FUNCTION:ADP-GITHUB:ITEMIZE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG22"></a>
#### Function: adpgh\:itemize \(\&rest elements\)

`````text
Inserts a bulleted list.

It can contains items or sublists, i.e., items, itemizes or enumerates.
`````

<a id="FUNCTION:ADP-GITHUB:LINK"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG34"></a>
#### Function: adpgh\:link \(\:address address \&rest elements\)

`````text
Inserts a link.

It must receive the keyword :address.
The rest of the elements will form the name of the link.
`````

<a id="FUNCTION:ADP-GITHUB:OUTPUT-FILE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG40"></a>
#### Function: adpgh\:output\-file \(pathname\)

`````text
Specifies the output file of the current scribble file.

The pathname is considered always relative to the project's root directory.
It doesn't print anything.
`````

<a id="FUNCTION:ADP-GITHUB:PACKAGE-DESCRIPTION"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG12"></a>
#### Macro: adpgh\:package\-description \(pkg \:tag \(tag \(make\-unique\-tag\)\)\)

`````text
Inserts a function description.

It must receive a package descriptor (not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with pref.
The tag must be a symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:PREF"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG6"></a>
#### Macro: adpgh\:pref \(name \&rest text\)

`````text
Inserts a reference to a package.

NAME must be a package descriptor (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:QUOTED"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG17"></a>
#### Function: adpgh\:quoted \(\&rest elements\)

`````text
Inserts quoted text.
`````

<a id="FUNCTION:ADP-GITHUB:ROW"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG39"></a>
#### Function: adpgh\:row \(\&rest cells\)

`````text
Inserts a row.

Rows can only be used inside a table.
`````

<a id="FUNCTION:ADP-GITHUB:SREF"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG26"></a>
#### Macro: adpgh\:sref \(name \&rest text\)

`````text
Makes a reference object to a system.
`````

<a id="FUNCTION:ADP-GITHUB:SUBSUBTITLE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG4"></a>
#### Macro: adpgh\:subsubtitle \(\:tag \(tag \(make\-unique\-tag\)\) \:toc \(toc t\) \&rest title\-elements\)

`````text
Returns a title of level 2.

It can be referenced if a TAG is specified (not evaluated).
If TOC is NIL it won't appear at any table of contents.
`````

<a id="FUNCTION:ADP-GITHUB:SUBTITLE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG31"></a>
#### Macro: adpgh\:subtitle \(\:tag \(tag \(make\-unique\-tag\)\) \:toc \(toc t\) \&rest title\-elements\)

`````text
Returns a subtitle of level 1.

It can be referenced if a TAG is specified (not evaluated).
If TOC is NIL it won't appear at any table of contents.
`````

<a id="FUNCTION:ADP-GITHUB:SYSTEM-DESCRIPTION"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG23"></a>
#### Macro: adpgh\:system\-description \(system\-des \:tag \(tag \(make\-unique\-tag\)\)\)

`````text
Inserts a system description.

It must receive a system descriptor (not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with sref.
The tag must be a symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:TABLE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG37"></a>
#### Function: adpgh\:table \(\&rest elements\)

`````text
Inserts a table.

The elements must be rows and rows can only contain cells..
`````

<a id="FUNCTION:ADP-GITHUB:TABLE-OF-CLASSES"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG13"></a>
#### Function: adpgh\:table\-of\-classes ()

`````text
Inserts references to function descriptions from the current file.
`````

<a id="FUNCTION:ADP-GITHUB:TABLE-OF-CONTENTS"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG9"></a>
#### Macro: adpgh\:table\-of\-contents \(\:min\-level \(min\-level 0\) \:max\-level \(max\-level 2\) \:include \(include nil\) \:exclude \(exclude nil\)\)

`````text
Inserts a table of contents with the titles of the current file.

MIN-LEVEL and MAX-LEVEL can be used to control what kind of titles should appear.
INCLUDE is a list with title tags forcing them to appear in the table of contents (not evaluated).
EXCLUDE is a list with title tags forcing them to not appear in the table of contents (not evaluated).
INCLUDE and EXCLUDE cannot share any tags.
`````

<a id="FUNCTION:ADP-GITHUB:TABLE-OF-FUNCTIONS"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG15"></a>
#### Function: adpgh\:table\-of\-functions ()

`````text
Inserts references to function descriptions from the current file.
`````

<a id="FUNCTION:ADP-GITHUB:TABLE-OF-VARIABLES"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG30"></a>
#### Function: adpgh\:table\-of\-variables ()

`````text
Inserts references to function descriptions from the current file.
`````

<a id="FUNCTION:ADP-GITHUB:TEXT"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG38"></a>
#### Function: adpgh\:text \(\:style \(style nil\) \&rest elements\)

`````text
Inserts text.

Text admits different styles:
  - nil       : Regular text.
  - :bold     : Bold text.
  - :italic   : Italic text.
  - :emphasis : Bold and italic text.
  - :code     : Inline code text.
`````

<a id="FUNCTION:ADP-GITHUB:TITLE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG18"></a>
#### Macro: adpgh\:title \(\:tag \(tag \(make\-unique\-tag\)\) \:toc \(toc t\) \&rest title\-elements\)

`````text
Inserts a title of level 0.

It can be referenced if a TAG is specified (not evaluated).
If TOC is NIL it won't appear at any table of contents.
`````

<a id="FUNCTION:ADP-GITHUB:TITLE*"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG2"></a>
#### Macro: adpgh\:title\* \(\:tag \(tag \(make\-unique\-tag\)\) \:toc \(toc t\) \:level \(level 0\) \&rest title\-elements\)

`````text
Inserts a title of a given LEVEL.

It can be referenced with tref if a TAG is specified.
If TOC is NIL it won't appear at any table of contents.
The LEVEL specifies the title level. 0 is a title, 1 is a subtitle, etc.
`````

<a id="FUNCTION:ADP-GITHUB:TREF"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG14"></a>
#### Macro: adpgh\:tref \(name \&rest text\)

`````text
Inserts a reference to a title.

NAME must be a symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:VARIABLE-DESCRIPTION"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG33"></a>
#### Macro: adpgh\:variable\-description \(name \:tag \(tag \(make\-unique\-tag\)\)\)

`````text
Inserts a variable description.

It must receive the variable name (a symbol, not evaluated).
The keyword :tag can be used to create an explicit tag that can be referenced with vref.
The tag must be a symbol (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:VARIABLE-GLOSSARY"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG24"></a>
#### Macro: adpgh\:variable\-glossary \(pkg\)

`````text
Inserts a variable glossary.

It will insert all the available variable descriptions from the external symbols of
the given package PKG.
The argument PKG must be a package descriptor (not evaluated).
`````

<a id="FUNCTION:ADP-GITHUB:VREF"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG10"></a>
#### Macro: adpgh\:vref \(name \&rest text\)

`````text
Inserts a reference to a variable.

NAME must be a symbol (not evaluated).
`````