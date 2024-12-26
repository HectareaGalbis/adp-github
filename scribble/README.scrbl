
(in-package #:adpgh-docs)

@output-file["/README.md"]

@title[:toc nil]{Add Documentation, Please... with Github Flavoured Markdown}

Welcome to ADP-GITHUB!

@code{ADP-GITHUB} is an exporter for @code{ADP}. It defines some functions and macros to print markdown-styled objects like titles, lists, code blocks and more. It also supports cross references and table of contents. Every symbol is exported from the @code{adp-github} package, although you can use the nickname @code{adpgh}.

@table-of-contents[]


@subtitle{Installation}

@itemize[
@item{Manual:}
]
@code-block[:lang "sh"]{
cd ~/common-lisp
git clone https://github.com/Hectarea1996/adp-github.git
}
@itemize[
@item{Quicklisp (Ultralisp):}
]
@code-block[:lang "common-lisp"]{
(ql-dist:install-dist "http://dist.ultralisp.org/" :prompt nil)
(ql:quickload "adp-github")
}


@subtitle{Documentation}

@itemize[
  @item{@tref[reference]}
  @item{@tref[user-guide]}
]


@subtitle{How to use}

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

@subtitle{Where the files are generated}

There is a simple rule and one expception. The rule says that every file is generated in a mirrored place under the @code{docs} directory. For example, the contents of file @code{scribble/myfile.scrbl} are printed into the file @code{docs/scribble/myfile.md}.

The exception is the use of @fref[output-file]. As the name suggest, you can select the output file. It accpets a pathname. That pathname is always treated as a relative path to the system's root directory.

