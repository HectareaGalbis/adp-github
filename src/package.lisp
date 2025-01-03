
(defpackage #:adp-github
  (:documentation "The main package of adp-github.")
  (:use #:cl #:alexandria)
  (:nicknames #:adpgh)
  (:export #:output-file #:title* #:title #:subtitle #:subsubtitle #:text #:tref #:fref #:vref #:cref #:pref
           #:sref #:clref #:cell #:row #:table #:item #:itemize #:enumerate #:table-of-contents
           #:table-of-functions #:table-of-variables #:table-of-classes #:image #:bold #:italic #:emphasis

           #:link

           #:code #:quoted #:code-block #:example

           #:function-description #:variable-description #:class-description #:package-description
           #:system-description

           #:function-glossary #:variable-glossary #:class-glossary))


(in-package #:adp-github)

(defpackage #:adp-github-writing
  (:documentation "The package used while writing.")
  (:use #:cl))

(defmacro with-writing-package (&body body)
  `(let ((*package* (find-package '#:adp-github-writing)))
     ,@body))
