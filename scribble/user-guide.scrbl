
(in-package #:adpgh-docs)


@title[:tag user-guide :toc nil]{User Guide}

Welcome to the ADP-GITHUB User Guide! I will try to do my best explaining how to use ADP-GITHUB. If this is not sufficient, note that every piece of documentation of ADP-GITHUB has been generated by itself. So you can see the source code and see how ADP-GITHUB has been used. For example, this file was generated using the source located at @code{scribble/user-guide.scrbl} .

@table-of-contents[]

@subtitle{Titles}

You can add titles in your documentation. So you can organize your guide with different sections (like I do in this guide). The macros that add titles are @fref[title*], @fref[title], @fref[subtitle] and @fref[subsubtitle]. They need a string as the first argument. For example, if I write this:

@code-block[:lang "common-lisp"]|{
@title[:toc nil]{This is a title}
@subtitle[:toc nil :tag tag-used-below]{This is a subtitle}
@subsubtitle[:toc nil]{This is a subsubtitle}
}|

You will see this:

@title[:toc nil]{This is a title}
@subtitle[:toc nil :tag tag-used-below]{This is a subtitle}
@subsubtitle[:toc nil]{This is a subsubtitle}

Note that they can receive a keyword argument @code{:toc}. If @code{nil} is used, these titles won't appear in any table of content.

Also, if we want additional levels for the title we should use @fref[title*]. Works the same way as others but accepts an additional keyword argument @code{:level}.

@subtitle{Table of contents}

We can create a table of contents with the function @fref[table-of-contents]. It will look for all titles used in the current file and make an hyperlink to these titles.

@code-block[:lang "text"]|{
@table-of-contents[]
}|

@table-of-contents[]

Additionally, we can specify the levels of titles that should appear. For example, we can specify only subsubtitles (titles of level 2):

@code-block[:lang "text"]|{
@table-of-contents[:min-level 2 :max-level 2]
}|

@table-of-contents[:min-level 2 :max-level 2]

We can also include or exclude specific titles using tags. If you look back the previous section we created a subtitle with the tag @code{tag-used-below}. Let's use it:

@code-block[:lang "text"]|{
@table-of-contents[:min-level 2 :max-level 2 :include (tag-used-below)]
}|

@table-of-contents[:min-level 2 :max-level 2 :include (tag-used-below)]

@subtitle{Tables}

You can add tables using the macros @fref[table], @fref[row] and @fref[cell]. The best way to see how to use it is an example. Imagine we have some info in our lisp files:

@example{
(defparameter peter-info '(34 "Peter Garcia" 1435))
(defparameter maria-info '(27 "Maria Martinez" 1765))
(defparameter laura-info '(53 "Laura Beneyto" 1543))

(defun get-age (info)
  (first info))

(defun get-name (info)
  (second info))

(defun get-salary (info)
  (third info))
}

Now we can create a table like this:

@code-block[:lang "common-lisp"]|{
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
    @cell[(get-age peter-info)] @cell[(get-name peter-info)] @cell[(get-salary peter-info)]{€}
  ]
  @row[
    @cell[(get-age maria-info)] @cell[(get-name maria-info)] @cell[(get-salary maria-info)]{€}
  ]
  @row[
    @cell[(get-age laura-info)] @cell[(get-name laura-info)] @cell[(get-salary laura-info)]{€}
  ]
]

@subtitle{Lists}

You can add lists with @fref[itemize] or @fref[enumerate]. For example:

@code-block[:lang "common-lisp"]|{
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

@subtitle{Text style}

We can enrich the text with the macros @fref[bold], @fref[italic], @fref[emphasis] and @fref[code]. For example:

@code-block[:lang "text"]|{
As @bold{Andrew} said: @italic{You only need @(+ 1 2 3)} @code{coins} @italic{to enter in} @emphasis{The Giant Red Tree}.
}|

You will see this:

As @bold{Andrew} said: @italic{You only need @(+ 1 2 3)} @code{coins} @italic{to enter in} @emphasis{The Giant Red Tree}.

You can nest @fref[bold] and @fref[italic] functions:

@code-block[:lang "text"]|{
The large @bold{house with @italic{the old woman}}.
}|

The large @bold{house with @italic{the old woman}}.

@subtitle{Hyperlinks}

Adding hyperlinks can be done with @fref[link]. It needs an web address and the text of the hyperlink.

@code-block[:lang "text"]|{
A link to the @link[:address "https://www.lispworks.com/documentation/HyperSpec/Front/index.htm"]{hyperspec}.
}|

You will see:

A link to the @link[:address "https://www.lispworks.com/documentation/HyperSpec/Front/index.htm"]{hyperspec}.

@subtitle{Quoted text}

You can quote text:

@code-block[:lang "text"]|{
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
}|

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

@subtitle{Images}

You can add images with the macro @fref[image]. For example, an image is located at @code{guides/images/}. If I evaluate the next expression:

@code-block[:lang "text"]|{
  @image["/images/Lisp_logo.svg" :alt-text "Lisp logo" :scale 0.1]
}|

You will see:

@image["/images/Lisp_logo.svg" :alt-text "Lisp logo" :scale 0.1]

The path is always treated as a relative pathname to the system's root directory.

@subtitle{Code blocks}

A good Lisp tutorial must include Lisp code examples. ADP defines some macros to print code blocks: @fref[code-block] and @fref[example]. The first macro does not evaluate the code. So, for example if you write this:

@code-block[:lang "text"]|{
  @code-block{
    (this is not (valid code))
    (but it (is (ok)))
  }
}|

You will see:

@code-block{
  (this is not (valid code))
  (but it (is (ok)))
}

The macro @fref[code-block] allows you to write non-Lisp code as well. It can receive, optionally, the language to be used:

@code-block[:lang "text"]|{
@code-block[:lang "c"]{
  int main(){
    printf("Hello world!");
    return 0;
  }     
}
}|

@code-block[:lang "c"]{
  int main(){
    printf("Hello world!");
    return 0;
  }     
}

If you want to print also @"@"-syntax expressions, you can use the @code["|{...}|"] form:

@code-block[:lang "text"]|{
@code-block[:lang "scribble"]|{
  @cmd[datum]{parse-body}     
}|
}|

@code-block[:lang "scribble"]|{
  @cmd[datum]{parse-body}     
}|

Lastly, @fref[example] evaluates the Lisp code you write on it. And what is more, it prints the standard output as well as the returned values. For example, writing this:

@code-block[:lang "text"]|{
@example{
  (loop for i from 0 below 10
        do (print i))
  (values "Hello" "world")
}
}|

You will see:

@example{
  (loop for i from 0 below 10
        do (print i))
  (values "Hello" "world")
}

See that we used the @code["{}"] form. I. e., we are writing text. It will be read and then evaluated. We can also use the @code["|{}|"] form to make scribble code to be printed:

@code-block[:lang "text"]|{
@example|{
  (print @+[3 4])
}|
}|

@example|{
  (print @+[3 4])
}|


@subtitle{Descriptions and cross references}

If we need to document our code, we may want to generate a refernce page where all the functions, variables or classes are described properly. Also, a good system to make a link to a description would be really nice.

ADP-GITHUB creates references from descriptions and titles. Each time you create a description or a title, a reference can be created to refer to that description or title.

There are five types of descriptions: @code{functions}, @code{variables}, @code{classes}, @code{packages} and @code{systems}. And each type of description can be referenced by a reference of the same type.


@subsubtitle{Descriptions}

Descriptions can be inserted with the functions @fref[function-description], @fref[variable-description], @fref[class-description], @fref[package-description] and @fref[system-description].

For example, ADP-GITHUB defines the function @fref[image] we've seen before. I we want a description of that function we need to write the following:

@code-block[:lang "common-lisp"]|{
@function-description[image]
}|

And we see this:

@function-description[image]

The same goes for the rest of functions. For example, we can see the description of the system @code{adp-github}.

@code-block[:lang "common-lisp"]|{
@system-description["adp-github"]
}|

@system-description["adp-github"]

Or its package:

@code-block[:lang "text"]|{
@package-description[#:adpgh]
}|

@package-description[#:adpgh]

For variables, let's get the internal symbol @code{adpgh::*tags*}.

@code-block[:lang "text"]|{
@variable-description[adpgh::*tags*]
}|

@variable-description[adpgh::*tags*]

Classes too. Let's define the following classes:

@example{
(defclass base-class () ())

(defclass complete-class (base-class)
  ((internal-slot :documentation "Some slot for internal use.")
   (title :reader complete-class-title
          :accessor complete-title
          :allocation :class))
  (:documentation
   "An example of a class with a lot of things."))
}

Let's see its description:

@code-block[:lang "text"]|{
@class-description[complete-class]
}|

@class-description[complete-class]

@subsubtitle{References}

We can differentiate between title references and description references. As you can guess, title references will reference to a title of any level. On the other hand, descriptions references will reference to a description.

The functions that inserts references are @fref[tref], @fref[fref], @fref[vref], @fref[cref], @fref[pref] and @fref[sref]. They insert a reference to a title, function, variable, class, package and system respectively.

The @fref[tref] function is a bit different from the others. It accepts a variable number of arguments, and it should receive a keyword argument @code{:tag}.

@code-block[:lang "common-lisp"]|{
@tref[user-guide]{A link to the top.}
}|

@tref[user-guide]{A link to the top.}

As you can see, the rest of elements received are used to indicate the text of the inserted link. The rest of reference functions also accept these elements to form the text to be shown. But, instead of receiving a @code{:tag} keyword they receive a symbol or a descriptor.

Above we've inserted a system description. We can now create a reference to that description:

@code-block[:lang "common-lisp"]|{
@sref["adp-github"]
}|

And we will see:

@sref["adp-github"]

Or, optionally, with text:

@code-block[:lang "common-lisp"]|{
@sref["adp-github"]{The system of adp-github.}
}|

And we will see:

@sref["adp-github"]{The system of adp-github.}


The same goes to the rest of types. However, there is one more thing we should know. If I use the following:

@code-block[:lang "common-lisp"]|{
@fref[image]
}|

@fref[image]

you will see that the link goes to the reference page and not to the description we wrote above. That's because glossaries (that we will explain in the following section) have precedence over single descriptions. 

Another useful function is @fref[clref]. With it, we can make reference to a Common Lisp Hyperspec symbol.

@code-block[:lang "text"]|{
@clref[prin1]
}|

@clref[prin1]


@subtitle{Glossaries}

A system may export a ton of symbols, maybe hundreds. For that reason we need some way to insert descriptions automatically. That is the job of glossaries. We have glossaries of three types: @code{functions}, @code{variables} and @code{classes}. They can be inserted with the functions @fref[function-glossary], @fref[variable-glossary] and @fref[class-glossary].

Each type of glossary will iterate over all the exported symbols looking for possible descriptions to insert. For example. the @fref[variable-glossary] will look for exported symbols that has a value associated with it. 

The best example I can show here is the @tref[reference]{reference page} of this project.


@subtitle{Table of symbols}

Similarly to table of contents, we can create a bunch of hyperlink to function, variable or class descriptions. These sets of hyperlinks are table of symbols. We can create them with @fref[table-of-functions], @fref[table-of-variables] and @fref[table-of-classes].

These table of symbols will only generate hyperlinks for the descriptions appearing in the current file.

For example, these are the function descriptions printed in this file:

@code-block[:lang "text"]|{
@table-of-functions[]
}|

@table-of-functions[]
