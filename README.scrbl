
(in-package #:adpgh)

@header{Add Documentation, Please... with Github Flavoured Markdown}

Welcome to ADP-GITHUB!

@inline{ADP-GITHUB} is an extension for @inline{ADP}. It exports some functions and macros to print markdown-styled objects like headers, lists, code blocks and more. It also supports cross references and table of contents. Every symbol is exported from the @inline{adp-github} package, although you can use the nickname @inline{adpgh}.

@mini-table-of-contents[]

@subheader{Documentation}

@itemize[
  @item{@href[reference]}
  @item{@href[user-guide]}
]

@subheader{How to use}

In your @inline{asd} file, you need to @inline{:defsystem-depends-on} the system @inline{adp-github}. Also, is really recommended to make a separate system only for documentation generation. And, lastly, you should specify @inline{:build-operation} to be @inline{"adp-github-op"}.

@verbatim-code-block[:lang "common-lisp"]{
(defsystem "my-system"
  :depends-on ("adp-github")  ; <- The main system should also depend on adp-github
  ;; ...
  ) 

(defsystem "my-system/docs"
  :defsystem-depends-on ("adp-github")
  :build-operation "adp-github-op"
  :components ((:file "main")
               (:scribble "README")))
}

Now, from the REPL, just evaluate the following expression:

@verbatim-code-block[:lang "common-lisp"]{
(asdf:make "my-system/docs")
}

@subheader{Where the files are generated}

There is a simple rule and one expception. The rule says that every file is generated in a mirrored place under the @inline{docs} directory. For example, the contents of file @inline{src/myfile.scrbl} are printed into the file @inline{docs/src/myfile.md}.

The exception is the file @inline{README.scrbl}. If that file is placed at the root directory, then the output is placed in the same place.

