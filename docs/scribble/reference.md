<a id="header-adp-github-reference"></a>
# Reference

#### Function: adpgh:bold (&rest elements)

Inserts text with bold style\.

#### Function: adpgh:cell (&rest elements)

The cells are the components of a row\. All the elements will be inserted inside a cell table\.

#### Macro: adpgh:class-description (sym)

Inserts a class description\. It must receive the class name \(a symbol\) that represents the class\. 
A class description also creates a class tag that can be used with cref\.

#### Macro: adpgh:class-glossary (pkg)

Inserts a class glossary\. It will insert all the available class descriptions\. They are gathered from
the external symbols of a given package\. The argument pkg must be a package descriptor\.

#### Function: adpgh:code (&rest elements)

Inserts text with code style\.

#### Function: adpgh:code-block (&rest elements)

Inserts a code of block\. It can receive the keyword \:lang\, a string that specifies the language to be used\.
The rest of elements will be inserted inside a block of code\.

#### Macro: adpgh:cref (sym)

Inserts a class reference\. I\. e\. a hyperlink to a class description\.

#### Function: adpgh:emphasis (&rest elements)

Inserts text with emphasis style\.

#### Function: adpgh:enumerate (&rest elements)

Inserts a enumerated lists\. It can contain items or sublist\. The elements must be items\, itemizes or enumerates\.

#### Macro: adpgh:example (&rest expressions)

Inserts an example\. It is like code\-block\, but evaluates the code \(common lisp only\) and prints its output
and returned values\.

#### Macro: adpgh:fref (sym)

Inserts a function reference\. I\. e\. a hyperlink to a function description\.

#### Macro: adpgh:function-description (sym)

Inserts a function description\. It must receive the function name \(a symbol\) that represents the function\. 
A function description also creates a function tag that can be used with fref\.

#### Macro: adpgh:function-glossary (pkg)

Inserts a function glossary\. It will insert all the available function descriptions\. They are gathered from
the external symbols of a given package\. The argument pkg must be a package descriptor\.

#### Macro: adpgh:header (&rest args)

Inserts a header\. Also\, a keyword \:tag can be supplied to be used as a header tag\.

#### Macro: adpgh:href (&rest elements)

Inserts a header reference\. I\. e\. a hyperlink to a header\.

#### Function: adpgh:image (path &key (alt-text "Image") (scale 1.0))

Inserts an image\. It must receive the path to the image \(relative to the project\'s root directory\)\.
Optionally\, it can receive an alternative text description and the scale size of the image\.

#### Function: adpgh:italic (&rest elements)

Inserts text with italic style\.

#### Function: adpgh:item (&rest elements)

Inserts an element if it is used inside an itemize or enumerate\.

#### Function: adpgh:itemize (&rest elements)

Inserts a list\. It can contains items or sublists\. The elements must be items\, itemizes or enumerates\.

#### Function: adpgh:link (&rest elements)

Inserts a link\. It must receive the keyword \:address\. The rest of the elements will form the name of the
link\.

#### Function: adpgh:mini-table-of-contents nil

Inserts a table of contents with the headers\, subheaders and subsubheaders of the current file\.

#### Macro: adpgh:package-description (pkg)

Inserts a package description\. It must receive a package descriptor that represents the package\. 
A package description also creates a package tag that can be used with pref\.

#### Macro: adpgh:pref (pkg)

Inserts a package reference\. I\. e\. a hyperlink to a package description\.

#### Function: adpgh:quoted (&rest elements)

Inserts quoted text\.

#### Function: adpgh:row (&rest elements)

The rows are the components of a table\. The elements must be cells\.

#### Macro: adpgh:sref (system-name)

Inserts a system reference\. I\. e\. a hyperlink to a system description\.

#### Macro: adpgh:subheader (&rest args)

Inserts a subheader\. Also\, a keyword \:tag can be supplied to be used as a header tag\.

#### Macro: adpgh:subsubheader (&rest args)

Inserts a subsubheader\. Also\, a keyword \:tag can be supplied to be used as a header tag\.

#### Macro: adpgh:system-description (system-name)

Inserts a system description\. It must receive a system description that represents the system\. 
A system description also creates a system tag that can be used with sref\.

#### Function: adpgh:table (&rest elements)

Inserts a table\. The elements must be rows\.

#### Function: adpgh:table-of-contents nil

Inserts a table of contents with the headers and subheaders of every generated file\.

#### Function: adpgh:table-of-functions nil

Inserts a table of function\. It is a list with references to all the functions that has a description
inserted somewhere\.

#### Function: adpgh:text (&rest elements)

Intended for using in lisp mode files or define custom functions\. Just inserts every argument\.

#### Macro: adpgh:variable-description (sym)

Inserts a variable description\. It must receive the variable name \(a symbol\) that represents the variable\. 
A variable description also creates a variable tag that can be used with vref\.

#### Macro: adpgh:variable-glossary (pkg)

Inserts a variable glossary\. It will insert all the available variable descriptions\. They are gathered from
the external symbols of a given package\. The argument pkg must be a package descriptor\.

#### Macro: adpgh:vref (sym)

Inserts a variable reference\. I\. e\. a hyperlink to a variable description\.