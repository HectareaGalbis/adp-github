

<a id="TITLE:ADPGH-DOCS:TAG15"></a>
# Add Documentation\, Please\.\.\. with Github Flavoured Markdown

Welcome to ADP\-GITHUB\!

```ADP-GITHUB``` is an exporter for ```ADP```\. It defines some functions and macros to print markdown\-styled objects like titles\, lists\, code blocks and more\. It also supports cross references and table of contents\. Every symbol is exported from the ```adp-github``` package\, although you can use the nickname ```adpgh```\.

* [Installation](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:TAG16)
* [Documentation](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:TAG17)
* [How to use](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:TAG18)
* [Where the files are generated](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:TAG19)



<a id="TITLE:ADPGH-DOCS:TAG16"></a>
## Installation

* Manual\:

`````sh
cd ~/common-lisp
git clone https://github.com/Hectarea1996/adp-github.git
`````
* Quicklisp \(Ultralisp\)\:

`````common-lisp
(ql-dist:install-dist "http://dist.ultralisp.org/" :prompt nil)
(ql:quickload "adp-github")
`````


<a id="TITLE:ADPGH-DOCS:TAG17"></a>
## Documentation

* [Reference](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:REFERENCE)
* [User Guide](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:USER-GUIDE)



<a id="TITLE:ADPGH-DOCS:TAG18"></a>
## How to use

In your ```asd``` file\, you need to ```:defsystem-depends-on``` the system ```adp-github```\. Also\, is really recommended to make a separate system only for documentation generation\. And\, lastly\, you should specify ```:build-operation``` to be ```"adp-github-op"```\.

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

<a id="TITLE:ADPGH-DOCS:TAG19"></a>
## Where the files are generated

There is a simple rule and one expception\. The rule says that every file is generated in a mirrored place under the ```docs``` directory\. For example\, the contents of file ```scribble/myfile.scrbl``` are printed into the file ```docs/scribble/myfile.md```\.

The exception is the use of [adpgh\:output\-file](//home/hectarea/common-lisp/adp-github/README.md#FUNCTION:ADP-GITHUB:OUTPUT-FILE)\. As the name suggest\, you can select the output file\. It accpets a pathname\. That pathname is always treated as a relative path to the system\'s root directory\.
