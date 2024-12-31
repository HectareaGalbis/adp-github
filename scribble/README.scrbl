
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
        @item{Quicklisp:}
]
@code-block[:lang "common-lisp"]{
(ql:quickload "adp-github")
}


@subtitle{Documentation}

@itemize[
  @item{@tref[reference]}
  @item{@tref[user-guide]}
]


@subtitle{How to use}

Make a subsystem of your project. For example, name it @code{my-project/docs}. You need to @code{:defsystem-depends-on} the system @code{adp-github}. And, lastly, you should specify the system @code{:class} to be @code{:adp-github}.

@code-block[:lang "common-lisp"]{
(defsystem "my-project"
  ;; ...
  ) 

(defsystem "my-project/docs"
  :defsystem-depends-on ("adp-github")
  :class :adp-github
  :depends-on ("my-system")
  :components ((:scribble "README")))
}

After writing some fancy scribble code into the file @code{README.scrbl}, just evaluate the following expression:

@code-block[:lang "common-lisp"]{
(asdf:load-system "my-system/docs")
}

@subtitle{Where the files are generated}

There is a simple rule and one expception. The rule says that every file is generated in a mirrored place under the @code{docs} directory. For example, the contents of file @code{scribble/myfile.scrbl} are printed into the file @code{docs/scribble/myfile.md}.

The exception is the use of @fref[output-file]. As the name suggest, you can select the output file. It accpets a pathname. That pathname is always treated as a relative path to the system's root directory.

