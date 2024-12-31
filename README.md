

<a id="TITLE:ADPGH-DOCS:TAG62"></a>
# Add Documentation\, Please\.\.\. with Github Flavoured Markdown

Welcome to ADP\-GITHUB\!

```ADP-GITHUB``` is an exporter for ```ADP```\. It defines some functions and macros to print markdown\-styled objects like titles\, lists\, code blocks and more\. It also supports cross references and table of contents\. Every symbol is exported from the ```adp-github``` package\, although you can use the nickname ```adpgh```\.

* [Installation](/README.md#TITLE:ADPGH-DOCS:TAG63)
* [Documentation](/README.md#TITLE:ADPGH-DOCS:TAG64)
* [How to use](/README.md#TITLE:ADPGH-DOCS:TAG65)
* [Where the files are generated](/README.md#TITLE:ADPGH-DOCS:TAG66)



<a id="TITLE:ADPGH-DOCS:TAG63"></a>
## Installation

* Manual\:

`````sh
cd ~/common-lisp
git clone https://github.com/Hectarea1996/adp-github.git
`````
* Quicklisp\:

`````common-lisp
(ql:quickload "adp-github")
`````


<a id="TITLE:ADPGH-DOCS:TAG64"></a>
## Documentation

* [Reference](/docs/scribble/reference.md#TITLE:ADPGH-DOCS:REFERENCE)
* [User Guide](/docs/scribble/user-guide.md#TITLE:ADPGH-DOCS:USER-GUIDE)



<a id="TITLE:ADPGH-DOCS:TAG65"></a>
## How to use

Make a subsystem of your project\. For example\, name it ```my-project/docs```\. You need to ```:defsystem-depends-on``` the system ```adp-github```\. And\, lastly\, you should specify the system ```:class``` to be ```:adp-github```\.

`````common-lisp
(defsystem "my-project"
  ;; ...
  )

(defsystem "my-project/docs"
  :defsystem-depends-on ("adp-github")
  :class :adp-github
  :depends-on ("my-system")
  :components ((:scribble "README")))
`````

After writing some fancy scribble code into the file ```README.scrbl```\, just evaluate the following expression\:

`````common-lisp
(asdf:load-system "my-system/docs")
`````

<a id="TITLE:ADPGH-DOCS:TAG66"></a>
## Where the files are generated

There is a simple rule and one expception\. The rule says that every file is generated in a mirrored place under the ```docs``` directory\. For example\, the contents of file ```scribble/myfile.scrbl``` are printed into the file ```docs/scribble/myfile.md```\.

The exception is the use of [adpgh\:output\-file](/docs/scribble/reference.md#FUNCTION:ADP-GITHUB:OUTPUT-FILE)\. As the name suggest\, you can select the output file\. It accpets a pathname\. That pathname is always treated as a relative path to the system\'s root directory\.
