

<a id="header-adp-github-headertag639"></a>
# Add Documentation\, Please\.\.\. with Github Flavoured Markdown

Welcome to ADP\-GITHUB\!

``` ADP-GITHUB ``` is an exporter for ``` ADP ```\. It defines some functions and macros to print markdown\-styled objects like headers\, lists\, code blocks and more\. It also supports cross references and table of contents\. Every symbol is exported from the ``` adp-github ``` package\, although you can use the nickname ``` adpgh ```\.

* [Add Documentation\, Please\.\.\. with Github Flavoured Markdown](/README.md#header-adp-github-headertag639)
  * [Documentation](/README.md#header-adp-github-headertag640)
  * [How to use](/README.md#header-adp-github-headertag641)
  * [Where the files are generated](/README.md#header-adp-github-headertag642)


<a id="header-adp-github-headertag640"></a>
## Documentation

* [Reference](/docs/scribble/reference.md#header-adp-github-reference)
* [User Guide](/docs/scribble/user-guide.md#header-adp-github-user-guide)


<a id="header-adp-github-headertag641"></a>
## How to use

In your ``` asd ``` file\, you need to ``` :defsystem-depends-on ``` the system ``` adp-github ```\. Also\, is really recommended to make a separate system only for documentation generation\. And\, lastly\, you should specify ``` :build-operation ``` to be ``` "adp-github-op" ```\.

`````common-lisp
(defsystem "my-system"
  ;; ...
  )

(defsystem "my-system/docs"
  :defsystem-depends-on ("adp-github")
  :build-operation "adp-github-op"
  :depends-on ("my-system")
  :components ((:scribble "README")))
`````

Now\, from the REPL\, just evaluate the following expression\:

`````common-lisp
(asdf:make "my-system/docs")
`````

<a id="header-adp-github-headertag642"></a>
## Where the files are generated

There is a simple rule and one expception\. The rule says that every file is generated in a mirrored place under the ``` docs ``` directory\. For example\, the contents of file ``` scribble/myfile.scrbl ``` are printed into the file ``` docs/scribble/myfile.md ```\.

The exception is the use of [adpgh\:select\-output\-file](/docs/scribble/reference.md#function-adp-github-select-output-file)\. As the name suggest\, you can select the output file\. It accpets a pathname\. That pathname is always treated as a relative path to the system\'s root directory\.
