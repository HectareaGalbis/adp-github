
(in-package #:adpgh)

@header{Add Documentation, Please... with Github Flavoured Markdown}

Welcome to ADP-GITHUB!

@code{ADP-GITHUB} is an exporter for @code{ADP}. It defines some functions and macros to print markdown-styled objects like headers, lists, code blocks and more. It also supports cross references and table of contents. Every symbol is exported from the @code{adp-github} package, although you can use the nickname @code{adpgh}.

@mini-table-of-contents[]

@subheader{Documentation}

@itemize[
  @item{@href[:tag reference]}
  @item{@href[:tag user-guide]}
]

@subheader{How to use}

In your @code{asd} file, you need to @code{:defsystem-depends-on} the system @code{adp-github}. Also, is really recommended to make a separate system only for documentation generation. And, lastly, you should specify @code{:build-operation} to be @code{"adp-github-op"}.

@code-block[:lang "common-lisp"]{
(defsystem "my-system"
  ;; ...
  ) 

(defsystem "my-system/docs"
  :defsystem-depends-on ("adp-github")
  :build-operation "adp-github-op"
  :depends-on ("my-system")
  :components ((:scribble "README")))
}

Now, from the REPL, just evaluate the following expression:

@code-block[:lang "common-lisp"]{
(asdf:make "my-system/docs")
}

@subheader{Where the files are generated}

There is a simple rule and one expception. The rule says that every file is generated in a mirrored place under the @code{docs} directory. For example, the contents of file @code{src/myfile.scrbl} are printed into the file @code{docs/src/myfile.md}.

The exception is the file @code{README.scrbl}. If that file is placed at the root directory, then the output is placed in the same place.

