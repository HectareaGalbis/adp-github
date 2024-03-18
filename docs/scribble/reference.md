<a id="header-adp-github-reference"></a>
# Reference

<a id="function-adp-github-bold"></a>
#### Function: adpgh:bold (&rest elements)

`````text
Inserts text with bold style.
`````

<a id="function-adp-github-cell"></a>
#### Function: adpgh:cell (&rest elements)

`````text
The cells are the components of a row. All the elements will be inserted inside a cell table.
`````

<a id="function-adp-github-class-description"></a>
#### Macro: adpgh:class-description (sym)

`````text
Inserts a class description. It must receive the class name (a symbol) that represents the class. 
A class description also creates a class tag that can be used with cref.
`````

<a id="function-adp-github-class-glossary"></a>
#### Macro: adpgh:class-glossary (pkg)

`````text
Inserts a class glossary. It will insert all the available class descriptions. They are gathered from
the external symbols of a given package. The argument pkg must be a package descriptor.
`````

<a id="function-adp-github-code"></a>
#### Function: adpgh:code (&rest elements)

`````text
Inserts text with code style.
`````

<a id="function-adp-github-code-block"></a>
#### Function: adpgh:code-block (&rest elements)

`````text
Inserts a code of block. It can receive the keyword :lang, a string that specifies the language to be used.
The rest of elements will be inserted inside a block of code.
`````

<a id="function-adp-github-cref"></a>
#### Macro: adpgh:cref (sym)

`````text
Inserts a class reference. I. e. a hyperlink to a class description.
`````

<a id="function-adp-github-emphasis"></a>
#### Function: adpgh:emphasis (&rest elements)

`````text
Inserts text with emphasis style.
`````

<a id="function-adp-github-enumerate"></a>
#### Function: adpgh:enumerate (&rest elements)

`````text
Inserts a enumerated lists. It can contain items or sublist. The elements must be items, itemizes or enumerates.
`````

<a id="function-adp-github-example"></a>
#### Macro: adpgh:example (&rest expressions)

`````text
Inserts an example. It is like code-block, but evaluates the code (common lisp only) and prints its output
and returned values.
`````

<a id="function-adp-github-fref"></a>
#### Macro: adpgh:fref (sym)

`````text
Inserts a function reference. I. e. a hyperlink to a function description.
`````

<a id="function-adp-github-function-description"></a>
#### Macro: adpgh:function-description (sym)

`````text
Inserts a function description. It must receive the function name (a symbol) that represents the function. 
A function description also creates a function tag that can be used with fref.
`````

<a id="function-adp-github-function-glossary"></a>
#### Macro: adpgh:function-glossary (pkg)

`````text
Inserts a function glossary. It will insert all the available function descriptions. They are gathered from
the external symbols of a given package. The argument pkg must be a package descriptor.
`````

<a id="function-adp-github-header"></a>
#### Macro: adpgh:header (&rest args)

`````text
Inserts a header. Also, a keyword :tag can be supplied to be used as a header tag.
`````

<a id="function-adp-github-href"></a>
#### Macro: adpgh:href (&rest elements)

`````text
Inserts a header reference. I. e. a hyperlink to a header.
`````

<a id="function-adp-github-image"></a>
#### Function: adpgh:image (path &key (alt-text "Image") (scale 1.0))

`````text
Inserts an image. It must receive the path to the image (relative to the project's root directory).
Optionally, it can receive an alternative text description and the scale size of the image.
`````

<a id="function-adp-github-italic"></a>
#### Function: adpgh:italic (&rest elements)

`````text
Inserts text with italic style.
`````

<a id="function-adp-github-item"></a>
#### Function: adpgh:item (&rest elements)

`````text
Inserts an element if it is used inside an itemize or enumerate.
`````

<a id="function-adp-github-itemize"></a>
#### Function: adpgh:itemize (&rest elements)

`````text
Inserts a list. It can contains items or sublists. The elements must be items, itemizes or enumerates.
`````

<a id="function-adp-github-link"></a>
#### Function: adpgh:link (&rest elements)

`````text
Inserts a link. It must receive the keyword :address. The rest of the elements will form the name of the
link.
`````

<a id="function-adp-github-mini-table-of-contents"></a>
#### Function: adpgh:mini-table-of-contents ()

`````text
Inserts a table of contents with the headers, subheaders and subsubheaders of the current file.
`````

<a id="function-adp-github-package-description"></a>
#### Macro: adpgh:package-description (pkg)

`````text
Inserts a package description. It must receive a package descriptor that represents the package. 
A package description also creates a package tag that can be used with pref.
`````

<a id="function-adp-github-pref"></a>
#### Macro: adpgh:pref (pkg)

`````text
Inserts a package reference. I. e. a hyperlink to a package description.
`````

<a id="function-adp-github-quoted"></a>
#### Function: adpgh:quoted (&rest elements)

`````text
Inserts quoted text.
`````

<a id="function-adp-github-row"></a>
#### Function: adpgh:row (&rest elements)

`````text
The rows are the components of a table. The elements must be cells.
`````

<a id="function-adp-github-sref"></a>
#### Macro: adpgh:sref (system-name)

`````text
Inserts a system reference. I. e. a hyperlink to a system description.
`````

<a id="function-adp-github-subheader"></a>
#### Macro: adpgh:subheader (&rest args)

`````text
Inserts a subheader. Also, a keyword :tag can be supplied to be used as a header tag.
`````

<a id="function-adp-github-subsubheader"></a>
#### Macro: adpgh:subsubheader (&rest args)

`````text
Inserts a subsubheader. Also, a keyword :tag can be supplied to be used as a header tag.
`````

<a id="function-adp-github-system-description"></a>
#### Macro: adpgh:system-description (system-name)

`````text
Inserts a system description. It must receive a system description that represents the system. 
A system description also creates a system tag that can be used with sref.
`````

<a id="function-adp-github-table"></a>
#### Function: adpgh:table (&rest elements)

`````text
Inserts a table. The elements must be rows.
`````

<a id="function-adp-github-table-of-contents"></a>
#### Function: adpgh:table-of-contents ()

`````text
Inserts a table of contents with the headers and subheaders of every generated file.
`````

<a id="function-adp-github-table-of-functions"></a>
#### Function: adpgh:table-of-functions ()

`````text
Inserts a table of function. It is a list with references to all the functions that has a description
inserted somewhere.
`````

<a id="function-adp-github-text"></a>
#### Function: adpgh:text (&rest elements)

`````text
Intended for using in lisp mode files or define custom functions. Just inserts every argument.
`````

<a id="function-adp-github-variable-description"></a>
#### Macro: adpgh:variable-description (sym)

`````text
Inserts a variable description. It must receive the variable name (a symbol) that represents the variable. 
A variable description also creates a variable tag that can be used with vref.
`````

<a id="function-adp-github-variable-glossary"></a>
#### Macro: adpgh:variable-glossary (pkg)

`````text
Inserts a variable glossary. It will insert all the available variable descriptions. They are gathered from
the external symbols of a given package. The argument pkg must be a package descriptor.
`````

<a id="function-adp-github-vref"></a>
#### Macro: adpgh:vref (sym)

`````text
Inserts a variable reference. I. e. a hyperlink to a variable description.
`````