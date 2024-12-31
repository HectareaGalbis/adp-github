

<a id="TITLE:ADPGH-DOCS:TAG63"></a>
# Add Documentation\, Please\.\.\. with Github Flavoured Markdown

Welcome to ADP\-GITHUB\!

```ADP-GITHUB``` is an exporter for ```ADP```\. It defines some functions and macros to print markdown\-styled objects like titles\, lists\, code blocks and more\. It also supports cross references and table of contents\. Every symbol is exported from the ```adp-github``` package\, although you can use the nickname ```adpgh```\.

* [Installation](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:TAG64)
* [Documentation](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:TAG65)
* [How to use](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:TAG66)
* [Where the files are generated](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:TAG67)



<a id="TITLE:ADPGH-DOCS:TAG64"></a>
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


<a id="TITLE:ADPGH-DOCS:TAG65"></a>
## Documentation

* [Reference](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:REFERENCE)
* [User Guide](//home/hectarea/common-lisp/adp-github/README.md#TITLE:ADPGH-DOCS:USER-GUIDE)



<a id="TITLE:ADPGH-DOCS:TAG66"></a>
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

Now\, from the REPL\, just evaluate the following expression\:

`````common-lisp
(asdf:load-system "my-system/docs")
`````

<a id="TITLE:ADPGH-DOCS:TAG67"></a>
## Where the files are generated

There is a simple rule and one expception\. The rule says that every file is generated in a mirrored place under the ```docs``` directory\. For example\, the contents of file ```scribble/myfile.scrbl``` are printed into the file ```docs/scribble/myfile.md```\.

The exception is the use of [adpgh\:output\-file](//home/hectarea/common-lisp/adp-github/README.md#FUNCTION:ADP-GITHUB:OUTPUT-FILE)\. As the name suggest\, you can select the output file\. It accpets a pathname\. That pathname is always treated as a relative path to the system\'s root directory\.
