
<a id="TITLE:ADPGH-DOCS:USER-GUIDE"></a>
# User Guide

Welcome to the ADP\-GITHUB User Guide\! I will try to do my best explaining how to use ADP\-GITHUB\. If this is not sufficient\, note that every piece of documentation of ADP\-GITHUB has been generated by itself\. So you can see the source code and see how ADP\-GITHUB has been used\. For example\, this file was generated using the source located at ```scribble/user-guide.scrbl``` \.

* [Titles](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG41)
* [Table of contents](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG44)
* [Tables](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG45)
* [Lists](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG46)
* [Text style](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG47)
* [Hyperlinks](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG48)
* [Quoted text](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG49)
* [Images](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG50)
* [Code blocks](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG51)
* [Descriptions and cross references](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG52)
  * [Descriptions](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG53)
  * [References](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG59)
* [Glossaries](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG60)
* [Table of symbols](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG61)


<a id="TITLE:ADPGH-DOCS:TAG41"></a>
## Titles

You can add titles in your documentation\. So you can organize your guide with different sections \(like I do in this guide\)\. The macros that add titles are [adpgh\:title\*](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TITLE*)\, [adpgh\:title](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TITLE)\, [adpgh\:subtitle](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:SUBTITLE) and [adpgh\:subsubtitle](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:SUBSUBTITLE)\. They need a string as the first argument\. For example\, if I write this\:

`````common-lisp
@title[:toc nil]{This is a title}
@subtitle[:toc nil :tag tag-used-below]{This is a subtitle}
@subsubtitle[:toc nil]{This is a subsubtitle}
`````

You will see this\:

<a id="TITLE:ADPGH-DOCS:TAG42"></a>
# This is a title
<a id="TITLE:ADPGH-DOCS:TAG-USED-BELOW"></a>
## This is a subtitle
<a id="TITLE:ADPGH-DOCS:TAG43"></a>
### This is a subsubtitle

Note that they can receive a keyword argument ```:toc```\. If ```nil``` is used\, these titles won\'t appear in any table of content\.

Also\, if we want additional levels for the title we should use [adpgh\:title\*](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TITLE*)\. Works the same way as others but accepts an additional keyword argument ```:level```\.

<a id="TITLE:ADPGH-DOCS:TAG44"></a>
## Table of contents

We can create a table of contents with the function [adpgh\:table\-of\-contents](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TABLE-OF-CONTENTS)\. It will look for all titles used in the current file and make an hyperlink to these titles\.

`````text
@table-of-contents[]
`````

* [Titles](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG41)
* [Table of contents](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG44)
* [Tables](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG45)
* [Lists](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG46)
* [Text style](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG47)
* [Hyperlinks](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG48)
* [Quoted text](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG49)
* [Images](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG50)
* [Code blocks](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG51)
* [Descriptions and cross references](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG52)
  * [Descriptions](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG53)
  * [References](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG59)
* [Glossaries](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG60)
* [Table of symbols](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG61)


Additionally\, we can specify the levels of titles that should appear\. For example\, we can specify only subsubtitles \(titles of level 2\)\:

`````text
@table-of-contents[:min-level 2 :max-level 2]
`````

* [Descriptions](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG53)
* [References](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG59)


We can also include or exclude specific titles using tags\. If you look back the previous section we created a subtitle with the tag ```tag-used-below```\. Let\'s use it\:

`````text
@table-of-contents[:min-level 2 :max-level 2 :include (tag-used-below)]
`````

* [This is a subtitle](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG-USED-BELOW)
  * [Descriptions](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG53)
  * [References](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:TAG59)


<a id="TITLE:ADPGH-DOCS:TAG45"></a>
## Tables

You can add tables using the macros [adpgh\:table](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TABLE)\, [adpgh\:row](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:ROW) and [adpgh\:cell](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:CELL)\. The best way to see how to use it is an example\. Imagine we have some info in our lisp files\:

`````common-lisp
(defparameter peter-info '(34 "Peter Garcia" 1435))
(defparameter maria-info '(27 "Maria Martinez" 1765))
(defparameter laura-info '(53 "Laura Beneyto" 1543))

(defun get-age (info)
  (first info))

(defun get-name (info)
  (second info))

(defun get-salary (info)
  (third info))
`````
`````common-lisp
;; Returns
GET-SALARY
`````

Now we can create a table like this\:

`````common-lisp
@table[
  @row[
    @cell{Age} @cell{Name} @cell{Salary}
  ]
  @row[
    @cell[(get-age peter-info)] @cell[(get-name peter-info)] @cell[(get-salary peter-info)]{€}
  ]
  @row[
    @cell[(get-age maria-info)] @cell[(get-name maria-info)] @cell[(get-salary maria-info)]{€}
  ]
  @row[
    @cell[(get-age laura-info)] @cell[(get-name laura-info)] @cell[(get-salary laura-info)]{€}
  ]
]
`````

And you will see this\:

<table>
<tr>
<td>Age</td><td>Name</td><td>Salary</td></tr><tr>
<td>34</td><td>Peter Garcia</td><td>1435€</td></tr><tr>
<td>27</td><td>Maria Martinez</td><td>1765€</td></tr><tr>
<td>53</td><td>Laura Beneyto</td><td>1543€</td></tr></table>

<a id="TITLE:ADPGH-DOCS:TAG46"></a>
## Lists

You can add lists with [adpgh\:itemize](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:ITEMIZE) or [adpgh\:enumerate](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:ENUMERATE)\. For example\:

`````common-lisp
@itemize[
  @item{Vegetables:}
  @enumerate[
    @item{3 peppers}
    @itemize[
      @item{1 green pepper}
      @item{@(- 3 1) red pepper}
    ]
    @item{0.25 Kg of carrots}
  ]
  @item{Fruits:}
  @enumerate[
    @item{0.5 Kg of apples}
    @item{6 oranges}
  ]
]
`````

You will see this\:

* Vegetables\:
  1. 3 peppers
     * 1 green pepper
     * 2 red pepper
  2. 0\.25 Kg of carrots
* Fruits\:
  1. 0\.5 Kg of apples
  2. 6 oranges


<a id="TITLE:ADPGH-DOCS:TAG47"></a>
## Text style

We can enrich the text with the macros [adpgh\:bold](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:BOLD)\, [adpgh\:italic](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:ITALIC)\, [adpgh\:emphasis](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:EMPHASIS) and [adpgh\:code](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:CODE)\. For example\:

`````text
As @bold{Andrew} said: @italic{You only need @(+ 1 2 3)} @code{coins} @italic{to enter in} @emphasis{The Giant Red Tree}.
`````

You will see this\:

As **Andrew** said\: _You only need 6_ ```coins``` _to enter in_ ***The Giant Red Tree***\.

You can nest [adpgh\:bold](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:BOLD) and [adpgh\:italic](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:ITALIC) functions\:

`````text
The large @bold{house with @italic{the old woman}}.
`````

The large **house with _the old woman_**\.

<a id="TITLE:ADPGH-DOCS:TAG48"></a>
## Hyperlinks

Adding hyperlinks can be done with [adpgh\:link](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:LINK)\. It needs an web address and the text of the hyperlink\.

`````text
A link to the @link[:address "https://www.lispworks.com/documentation/HyperSpec/Front/index.htm"]{hyperspec}.
`````

You will see\:

A link to the [hyperspec](https://www.lispworks.com/documentation/HyperSpec/Front/index.htm)\.

<a id="TITLE:ADPGH-DOCS:TAG49"></a>
## Quoted text

You can quote text\:

`````text
@quoted{
A driller by day
A driller by night
Bugs never hurt
As they're frozen from fright

My c4 goes boom
Sharp as a ruler
Just me and my baby
@italic{Perfectly Tuned Cooler}

- A Deep Rock Galactic poem by @link[:address "https://www.reddit.com/user/TEAdown/"]{TEAdown}
}
`````

> A driller by day<br>
> A driller by night<br>
> Bugs never hurt<br>
> As they\'re frozen from fright<br>
> <br>
> My c4 goes boom<br>
> Sharp as a ruler<br>
> Just me and my baby<br>
> _Perfectly Tuned Cooler_<br>
> <br>
> \- A Deep Rock Galactic poem by [TEAdown](https://www.reddit.com/user/TEAdown/)

<a id="TITLE:ADPGH-DOCS:TAG50"></a>
## Images

You can add images with the macro [adpgh\:image](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:IMAGE)\. For example\, an image is located at ```guides/images/```\. If I evaluate the next expression\:

`````text
@image["/images/Lisp_logo.svg" :alt-text "Lisp logo" :scale 0.1]
`````

You will see\:

<img src="/images/Lisp_logo.svg" alt="Lisp logo" width="10%">

The path is always treated as a relative pathname to the system\'s root directory\.

<a id="TITLE:ADPGH-DOCS:TAG51"></a>
## Code blocks

A good Lisp tutorial must include Lisp code examples\. ADP defines some macros to print code blocks\: [adpgh\:code\-block](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:CODE-BLOCK) and [adpgh\:example](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:EXAMPLE)\. The first macro does not evaluate the code\. So\, for example if you write this\:

`````text
@code-block{
  (this is not (valid code))
  (but it (is (ok)))
}
`````

You will see\:

`````
(this is not (valid code))
(but it (is (ok)))
`````

The macro [adpgh\:code\-block](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:CODE-BLOCK) allows you to write non\-Lisp code as well\. It can receive\, optionally\, the language to be used\:

`````text
@code-block[:lang "c"]{
  int main(){
    printf("Hello world!");
    return 0;
  }
}
`````

`````c
int main(){
  printf("Hello world!");
  return 0;
}
`````

If you want to print also \@\-syntax expressions\, you can use the ```|{...}|``` form\:

`````text
@code-block[:lang "scribble"]|{
  @cmd[datum]{parse-body}
}|
`````

`````scribble
@cmd[datum]{parse-body}
`````

Lastly\, [adpgh\:example](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:EXAMPLE) evaluates the Lisp code you write on it\. And what is more\, it prints the standard output as well as the returned values\. For example\, writing this\:

`````text
@example{
  (loop for i from 0 below 10
        do (print i))
  (values "Hello" "world")
}
`````

You will see\:

`````common-lisp
(loop for i from 0 below 10
      do (print i))
(values "Hello" "world")
`````
`````text
;; Output

0 
1 
2 
3 
4 
5 
6 
7 
8 
9 
`````
`````common-lisp
;; Returns
"Hello"
"world"
`````

See that we used the ```{}``` form\. I\. e\.\, we are writing text\. It will be read and then evaluated\. We can also use the ```|{}|``` form to make scribble code to be printed\:

`````text
@example|{
  (print @+[3 4])
}|
`````

`````common-lisp
(print @+[3 4])
`````
`````text
;; Output

7 
`````
`````common-lisp
;; Returns
7
`````


<a id="TITLE:ADPGH-DOCS:TAG52"></a>
## Descriptions and cross references

If we need to document our code\, we may want to generate a refernce page where all the functions\, variables or classes are described properly\. Also\, a good system to make a link to a description would be really nice\.

ADP\-GITHUB creates references from descriptions and titles\. Each time you create a description or a title\, a reference can be created to refer to that description or title\.

There are five types of descriptions\: ```functions```\, ```variables```\, ```classes```\, ```packages``` and ```systems```\. And each type of description can be referenced by a reference of the same type\.


<a id="TITLE:ADPGH-DOCS:TAG53"></a>
### Descriptions

Descriptions can be inserted with the functions [adpgh\:function\-description](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:FUNCTION-DESCRIPTION)\, [adpgh\:variable\-description](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:VARIABLE-DESCRIPTION)\, [adpgh\:class\-description](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:CLASS-DESCRIPTION)\, [adpgh\:package\-description](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:PACKAGE-DESCRIPTION) and [adpgh\:system\-description](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:SYSTEM-DESCRIPTION)\.

For example\, ADP\-GITHUB defines the function [adpgh\:image](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:IMAGE) we\'ve seen before\. I we want a description of that function we need to write the following\:

`````common-lisp
@function-description[image]
`````

And we see this\:

<a id="FUNCTION:ADP-GITHUB:IMAGE"></a>
<a id="FUNCTION:ADPGH-DOCS:TAG54"></a>
#### Function: adpgh\:image \(\&rest args\-sym\)

`````text
Inserts an image.

It must receive the path to the image (relative to the project's root directory).
Optionally, it can receive an alternative text description and the scale size of the image.
`````

The same goes for the rest of functions\. For example\, we can see the description of the system ```adp-github```\.

`````common-lisp
@system-description["adp-github"]
`````

<a id="SYSTEM:KEYWORD:ADP-GITHUB"></a>
<a id="SYSTEM:ADPGH-DOCS:TAG55"></a>
#### System: adp\-github

`````text
ADP extension to generate github markdown files.
`````

* Author: Héctor Galbis Sanchis
* License: MIT
* Depends on: alexandria, closer\-mop, adp, trivial\-arguments, hyperspec, cl\-ppcre

Or its package\:

`````text
@package-description[#:adpgh]
`````

<a id="PACKAGE:KEYWORD:ADP-GITHUB"></a>
<a id="PACKAGE:ADPGH-DOCS:TAG56"></a>
#### Package: ADP\-GITHUB

`````text
The main package of adp-github.
`````

* Nicknames: ADPGH
* Exported symbols: ```bold```, ```cell```, ```class-description```, ```class-glossary```, ```clref```, ```code```, ```code-block```, ```cref```, ```emphasis```, ```enumerate```, ```example```, ```fref```, ```function-description```, ```function-glossary```, ```image```, ```italic```, ```item```, ```itemize```, ```link```, ```output-file```, ```package-description```, ```pref```, ```quoted```, ```row```, ```sref```, ```subsubtitle```, ```subtitle```, ```system-description```, ```table```, ```table-of-classes```, ```table-of-contents```, ```table-of-functions```, ```table-of-variables```, ```text```, ```title```, ```title*```, ```tref```, ```variable-description```, ```variable-glossary```, ```vref```

For variables\, let\'s get the internal symbol ```adpgh::*tags*```\.

`````text
@variable-description[adpgh::*tags*]
`````

<a id="VARIABLE:ADP-GITHUB:*TAGS*"></a>
<a id="VARIABLE:ADPGH-DOCS:TAG57"></a>
#### Variable: adpgh\:\:\*tags\*

`````text
The tags container.
`````

Classes too\. Let\'s define the following classes\:

`````common-lisp
(defclass base-class () ())

(defclass complete-class (base-class)
  ((internal-slot :documentation "Some slot for internal use.")
   (title :reader complete-class-title
          :accessor complete-title
          :allocation :class))
  (:documentation
   "An example of a class with a lot of things."))
`````
`````common-lisp
;; Returns
#<STANDARD-CLASS ADPGH-DOCS::COMPLETE-CLASS>
`````

Let\'s see its description\:

`````text
@class-description[complete-class]
`````

<a id="CLASS:ADPGH-DOCS:COMPLETE-CLASS"></a>
<a id="CLASS:ADPGH-DOCS:TAG58"></a>
#### Class: adpgh\-docs\:\:complete\-class
`````text
An example of a class with a lot of things.
`````
* Direct slots\:
  * ```adpgh-docs::internal-slot```
    * ```Some slot for internal use.```
    * Allocation\: ```:instance```
  * ```adpgh:title```
    * Allocation\: ```:class```
    * Readers\: ```adpgh-docs::complete-title```\, ```adpgh-docs::complete-class-title```
    * Writers\: ```(setf adpgh-docs::complete-title)```


* Metaclass: ```standard-class```
* Precedence list: ```adpgh-docs::complete-class```, ```adpgh-docs::base-class```, ```standard-object```, ```sb-pcl::slot-object```, ```t```
* Direct superclasses: ```adpgh-docs::base-class```


<a id="TITLE:ADPGH-DOCS:TAG59"></a>
### References

We can differentiate between title references and description references\. As you can guess\, title references will reference to a title of any level\. On the other hand\, descriptions references will reference to a description\.

The functions that inserts references are [adpgh\:tref](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TREF)\, [adpgh\:fref](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:FREF)\, [adpgh\:vref](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:VREF)\, [adpgh\:cref](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:CREF)\, [adpgh\:pref](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:PREF) and [adpgh\:sref](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:SREF)\. They insert a reference to a title\, function\, variable\, class\, package and system respectively\.

The [adpgh\:tref](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TREF) function is a bit different from the others\. It accepts a variable number of arguments\, and it should receive a keyword argument ```:tag```\.

`````common-lisp
@tref[user-guide]{A link to the top.}
`````

[A link to the top\.](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:USER-GUIDE)

As you can see\, the rest of elements received are used to indicate the text of the inserted link\. The rest of reference functions also accept these elements to form the text to be shown\. But\, instead of receiving a ```:tag``` keyword they receive a symbol or a descriptor\.

Above we\'ve inserted a system description\. We can now create a reference to that description\:

`````common-lisp
@sref["adp-github"]
`````

And we will see\:

[adp\-github](/docs/scribble/user-guide.md#SYSTEM:KEYWORD:ADP-GITHUB)

Or\, optionally\, with text\:

`````common-lisp
@sref["adp-github"]{The system of adp-github.}
`````

And we will see\:

[The system of adp\-github\.](/docs/scribble/user-guide.md#SYSTEM:KEYWORD:ADP-GITHUB)


The same goes to the rest of types\. However\, there is one more thing we should know\. If I use the following\:

`````common-lisp
@fref[image]
`````

[adpgh\:image](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:IMAGE)

you will see that the link goes to the reference page and not to the description we wrote above\. That\'s because glossaries \(that we will explain in the following section\) have precedence over single descriptions\.

Another useful function is [adpgh\:clref](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:CLREF)\. With it\, we can make reference to a Common Lisp Hyperspec symbol\.

`````text
@clref[prin1]
`````

[prin1](http://www.lispworks.com/reference/HyperSpec/Body/f_wr_pr.htm)


<a id="TITLE:ADPGH-DOCS:TAG60"></a>
## Glossaries

A system may export a ton of symbols\, maybe hundreds\. For that reason we need some way to insert descriptions automatically\. That is the job of glossaries\. We have glossaries of three types\: ```functions```\, ```variables``` and ```classes```\. They can be inserted with the functions [adpgh\:function\-glossary](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:FUNCTION-GLOSSARY)\, [adpgh\:variable\-glossary](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:VARIABLE-GLOSSARY) and [adpgh\:class\-glossary](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:CLASS-GLOSSARY)\.

Each type of glossary will iterate over all the exported symbols looking for possible descriptions to insert\. For example\. the [adpgh\:variable\-glossary](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:VARIABLE-GLOSSARY) will look for exported symbols that has a value associated with it\.

The best example I can show here is the [reference page](/docs/scribble/reference.md#TITLE:ADPGH-DOCS:REFERENCE) of this project\.


<a id="TITLE:ADPGH-DOCS:TAG61"></a>
## Table of symbols

Similarly to table of contents\, we can create a bunch of hyperlink to function\, variable or class descriptions\. These sets of hyperlinks are table of symbols\. We can create them with [adpgh\:table\-of\-functions](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TABLE-OF-FUNCTIONS)\, [adpgh\:table\-of\-variables](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TABLE-OF-VARIABLES) and [adpgh\:table\-of\-classes](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:TABLE-OF-CLASSES)\.

These table of symbols will only generate hyperlinks for the descriptions appearing in the current file\.

For example\, these are the function descriptions printed in this file\:

`````text
@table-of-functions[]
`````

* [adpgh\:image](/docs/scribble/user-guide.md#FUNCTION:ADPGH-DOCS:TAG54)
