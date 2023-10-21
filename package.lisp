
(defpackage #:adp-github
  (:use #:cl #:alexandria)
  (:nicknames #:adpgh)
  (:export #:header #:subheader #:subsubheader #:text #:href #:fref #:vref #:cref #:pref #:sref #:cell #:row
           #:table #:item #:itemize #:enumerate #:table-of-contents #:mini-table-of-contents #:table-of-functions
           #:table-of-symbols #:table-of-types #:image #:bold #:italic #:emphasis #:inline #:link #:quoted
           #:code-block #:example

           #:function-description #:variable-description #:class-description #:package-description
           #:system-description

           #:function-glossary #:variable-glossary #:class-glossary

           #:*tags*))
