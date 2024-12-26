<a id="TITLE:ADPGH-DOCS:REFERENCE"></a>
# Reference

<a id="FUNCTION:ADP-GITHUB:BOLD"></a>
#### Function: adpgh:bold (&rest elements)

`````text
Inserts text with bold style.
`````

<a id="FUNCTION:ADP-GITHUB:CELL"></a>
#### Function: adpgh:cell (&rest elements)

`````text
The cells are the components of a row. All the elements will be inserted inside a cell table.
`````

<a id="FUNCTION:ADP-GITHUB:CLASS-DESCRIPTION"></a>
#### Macro: adpgh:class-description (sym)

`````text
Inserts a class description. It must receive the class name (a symbol) that represents the class. 
A class description also creates a class tag that can be used with cref.
`````

<a id="FUNCTION:ADP-GITHUB:CLASS-GLOSSARY"></a>
#### Macro: adpgh:class-glossary (pkg)

`````text
Inserts a function glossary. It will insert all the available function descriptions.
They are gathered from the external symbols of a given package.
The argument pkg must be a package descriptor.
`````

<a id="FUNCTION:ADP-GITHUB:CLREF"></a>
#### Macro: adpgh:clref (sym)

`````text
Inserts a hyperlink to the Common Lisp Hyperspec for a given symbol.
`````

<a id="FUNCTION:ADP-GITHUB:CODE"></a>
#### Function: adpgh:code (&rest elements)

`````text
Inserts text with code style.
`````

<a id="FUNCTION:ADP-GITHUB:CODE-BLOCK"></a>
#### Function: adpgh:code-block (:lang (lang nil) &rest elements)

`````text
Inserts a code of block. It can receive the keyword :lang, a string that specifies the language to be used.
The rest of elements will be inserted inside a block of code.
`````

<a id="FUNCTION:ADP-GITHUB:CREF"></a>
#### Macro: adpgh:cref (symbol0 &rest text1)

`````text
Makes a reference object to a class.
`````

<a id="FUNCTION:ADP-GITHUB:EMPHASIS"></a>
#### Function: adpgh:emphasis (&rest elements)

`````text
Inserts text with emphasis style.
`````

<a id="FUNCTION:ADP-GITHUB:ENUMERATE"></a>
#### Function: adpgh:enumerate (&rest elements)

`````text
Inserts a enumerated lists. It can contain items or sublist. The elements must be items, itemizes or enumerates.
`````

<a id="FUNCTION:ADP-GITHUB:EXAMPLE"></a>
#### Function: adpgh:example (&rest expressions)

`````text
Inserts an example. It is like code-block, but evaluates the code (common lisp only) and prints
its output and returned values.
`````

<a id="FUNCTION:ADP-GITHUB:FREF"></a>
#### Macro: adpgh:fref (symbol0 &rest text1)

`````text
Makes a reference object to a function.
`````

<a id="FUNCTION:ADP-GITHUB:FUNCTION-DESCRIPTION"></a>
#### Macro: adpgh:function-description (name)

`````text
Inserts a function description. It must receive the function name (a symbol) that represents the function. 
A function description also creates a function tag that can be used with fref.
`````

<a id="FUNCTION:ADP-GITHUB:FUNCTION-GLOSSARY"></a>
#### Macro: adpgh:function-glossary (pkg)

`````text
Inserts a function glossary. It will insert all the available function descriptions.
They are gathered from the external symbols of a given package.
The argument pkg must be a package descriptor.
`````

<a id="FUNCTION:ADP-GITHUB:IMAGE"></a>
#### Function: adpgh:image (path :alt-text (alt-text "Image") :scale (scale 1.0))

`````text
Inserts an image. It must receive the path to the image (relative to the project's root directory).
Optionally, it can receive an alternative text description and the scale size of the image.
`````

<a id="FUNCTION:ADP-GITHUB:ITALIC"></a>
#### Function: adpgh:italic (&rest elements)

`````text
Inserts text with italic style.
`````

<a id="FUNCTION:ADP-GITHUB:ITEM"></a>
#### Function: adpgh:item (&rest elements)

`````text
Inserts an element if it is used inside an itemize or enumerate.
`````

<a id="FUNCTION:ADP-GITHUB:ITEMIZE"></a>
#### Function: adpgh:itemize (&rest elements)

`````text
Inserts a list. It can contains items or sublists. The elements must be items, itemizes or enumerates.
`````

<a id="FUNCTION:ADP-GITHUB:LINK"></a>
#### Function: adpgh:link (:address address &rest elements)

`````text
Inserts a link. It must receive the keyword :address. The rest of the elements will form the name of the
link.
`````

<a id="FUNCTION:ADP-GITHUB:OUTPUT-FILE"></a>
#### Function: adpgh:output-file (pathname)

`````text
Specifies the output file of the current scribble file.
The pathname is considered always relative to the project's root directory.
`````

<a id="FUNCTION:ADP-GITHUB:PACKAGE-DESCRIPTION"></a>
#### Macro: adpgh:package-description (pkg)

`````text
Inserts a package description. It must receive a package descriptor that represents the package. 
A package description also creates a package tag that can be used with pref.
`````

<a id="FUNCTION:ADP-GITHUB:PREF"></a>
#### Macro: adpgh:pref (name &rest text)

`````text
Makes a reference object to a package.
`````

<a id="FUNCTION:ADP-GITHUB:QUOTED"></a>
#### Function: adpgh:quoted (&rest elements)

`````text
Inserts quoted text.
`````

<a id="FUNCTION:ADP-GITHUB:ROW"></a>
#### Function: adpgh:row (&rest cells)

`````text
The rows are the components of a table. The CELLS must be objects of type cell.
`````

<a id="FUNCTION:ADP-GITHUB:SREF"></a>
#### Macro: adpgh:sref (name &rest text)

`````text
Makes a reference object to a system.
`````

<a id="FUNCTION:ADP-GITHUB:SUBSUBTITLE"></a>
#### Macro: adpgh:subsubtitle (:tag (tag (make-unique-tag)) :toc (toc t) &rest title-elements)

`````text
Returns a subsubtitle object.

It can be referenced if a TAG is specified.
If TOC is NIL it won't appear at any table of contents.
`````

<a id="FUNCTION:ADP-GITHUB:SUBTITLE"></a>
#### Macro: adpgh:subtitle (:tag (tag (make-unique-tag)) :toc (toc t) &rest title-elements)

`````text
Returns a subtitle object.

It can be referenced if a TAG is specified.
If TOC is NIL it won't appear at any table of contents.
`````

<a id="FUNCTION:ADP-GITHUB:SYSTEM-DESCRIPTION"></a>
#### Macro: adpgh:system-description (system-des)

`````text
Inserts a system description. It must receive a system description that represents the system. 
A system description also creates a system tag that can be used with sref.
`````

<a id="FUNCTION:ADP-GITHUB:TABLE"></a>
#### Function: adpgh:table (&rest elements)

`````text
Inserts a table. The elements must be rows.
`````

<a id="FUNCTION:ADP-GITHUB:TABLE-OF-CONTENTS"></a>
#### Function: adpgh:table-of-contents (:min-level (min-level 0) :max-level (max-level 2) :include (include nil) :exclude (exclude nil))

`````text
Inserts a table of contents with the titles of the current file.
`````

<a id="FUNCTION:ADP-GITHUB:TEXT"></a>
#### Function: adpgh:text (:style style &rest elements)

`````text
Returns a text object.
`````

<a id="FUNCTION:ADP-GITHUB:TITLE"></a>
#### Macro: adpgh:title (:tag (tag (make-unique-tag)) :toc (toc t) &rest title-elements)

`````text
Returns a title object.

It can be referenced if a TAG is specified.
If TOC is NIL it won't appear at any table of contents.
`````

<a id="FUNCTION:ADP-GITHUB:TITLE*"></a>
#### Macro: adpgh:title* (:tag (tag (make-unique-tag)) :toc (toc t) :level (level 0) &rest title-elements)

`````text
Returns a title object of a given LEVEL.

It can be referenced if a TAG is specified.
If TOC is NIL it won't appear at any table of contents.
The LEVEL specified the title level. 0 is a title, 1 is a subtitle, etc.
`````

<a id="FUNCTION:ADP-GITHUB:TREF"></a>
#### Macro: adpgh:tref (symbol0 &rest text1)

`````text
Makes a reference object to a title.
`````

<a id="FUNCTION:ADP-GITHUB:VARIABLE-DESCRIPTION"></a>
#### Macro: adpgh:variable-description (name)

`````text
Inserts a variable description. It must receive the variable name (a symbol) that represents the variable. 
A variable description also creates a variable tag that can be used with vref.
`````

<a id="FUNCTION:ADP-GITHUB:VARIABLE-GLOSSARY"></a>
#### Macro: adpgh:variable-glossary (pkg)

`````text
Inserts a function glossary. It will insert all the available function descriptions.
They are gathered from the external symbols of a given package.
The argument pkg must be a package descriptor.
`````

<a id="FUNCTION:ADP-GITHUB:VREF"></a>
#### Macro: adpgh:vref (symbol0 &rest text1)

`````text
Makes a reference object to a variable.
`````