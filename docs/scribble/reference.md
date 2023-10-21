<a id="header-adp-github-reference"></a>
# Reference

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