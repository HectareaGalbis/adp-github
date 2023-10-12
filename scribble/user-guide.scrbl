
(in-package #:adpgh)


@header[:tag user-guide]{User Guide}

Welcome to the ADP User Guide! Here you will learn how to add documentation to your projects using ADP. ADP can be divided in two groups of functions. The API functions and Guide function. However, despite that distinction all the functions can be mixed to generate your documentation.

I will try to do my best explaining how to use ADP. If this is not sufficient, note that every piece of documentation of ADP has been generated by itself. So you can see the source code and see how ADP has been used. For example, this file was generated using the source located at @inline{guides/user-guide.lisp} .

@mini-table-of-contents[]

@subheader{Headers}

You can add headers in your documentation. In other words, they work as titles or subtitles. You can this way organize your guide with different sections (like I do in this guide). The macros that add headers are @fref[header], @fref[subheader] and @fref[subsubheader]. They need a string as the first argument. For example, if I write this:

@verbatim-code-block[:lang "common-lisp"]|{
@header{This is a header}
@subheader{This is a subheader}
@subsubheader{This is a subsubheader}
}|

You will see this:

@header{This is a header}
@subheader{This is a subheader}
@subsubheader{This is a subsubheader}

@subheader{Tables}

You can add tables using the macros @fref[table], @fref[row] and @fref[cell]. The best way to see how to use it is an example. Imagine we have some info in our lisp files:

@code-block[
  (cl:defparameter peter-info '(34 "Peter Garcia" 1435))
  (cl:defparameter maria-info '(27 "Maria Martinez" 1765))
  (cl:defparameter laura-info '(53 "Laura Beneyto" 1543))

  (cl:defun get-age (info)
    (first info))

  (cl:defun get-name (info)
    (second info))

  (cl:defun get-salary (info)
    (third info))
]

Now we can create a table like this:

@verbatim-code-block[:lang "common-lisp"]|{
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
}|

And you will see this:

@table[
  @row[
    @cell{Age} @cell{Name} @cell{Salary}
  ]
  @row[
    @cell[34] @cell["Peter Garcia"] @cell[1435]{€}
  ]
  @row[
    @cell[27] @cell["Maria Martinez"] @cell[1765]{€}
  ]
  @row[
    @cell[53] @cell["Laura Beneyto"] @cell[1543]{€}
  ]
]

@subheader{Lists}

You can add lists with @fref[itemize] or @fref[enumerate]. For example:

@verbatim-code-block[:lang "common-lisp"]|{
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
}|

You will see this:

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

@subheader{Text style}

We can enrich the text with the macros @fref[bold], @fref[italic], @fref[emphasis] and @fref[link]. For example:

@verbatim-code-block[:lang "text"]|{
As @bold{Andrew} said: @italic{You only need @(+ 1 2 3)} @link[:address "https://en.wikipedia.org/wiki/Coin"]{coins} @italic{to enter in} @emphasis{The Giant Red Tree}.
}|

You will see this:

As @bold{Andrew} said: @italic{You only need @(+ 1 2 3)} @link[:address "https://en.wikipedia.org/wiki/Coin"]{coins} @italic{to enter in} @emphasis{The Giant Red Tree}.

You can nest @fref[bold] and @fref[italic] functions:

@verbatim-code-block[:lang "text"]|{
The large @bold{house with @italic{the old woman}}.
}|

The large @bold{house with @italic{the old woman}}.

Lastly, you can quote text:

@verbatim-code-block[:lang "text"]|{
@quote{
A driller by day
A driller by night
Bugs never hurt
As they're frozen from fright

My c4 goes boom
Sharp as a ruler
Just me and my baby
@italic{Perfectly Tuned Cooler}

- @link[:address "https://www.reddit.com/user/TEAdown/"]{TEAdown}
}
}|

@quote{
A driller by day
A driller by night
Bugs never hurt
As they're frozen from fright

My c4 goes boom
Sharp as a ruler
Just me and my baby
@italic{Perfectly Tuned Cooler}

- @link[:address "https://www.reddit.com/user/TEAdown/"]{TEAdown}
}