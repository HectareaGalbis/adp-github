
(defsystem "adp-github"
  :author "Héctor Galbis Sanchis"
  :description "ADP extension to generate github markdown files."
  :license "MIT"
  :depends-on ("alexandria" "closer-mop" "adp" "trivial-arguments" "hyperspec")
  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "pprint-dispatch")
                             (:file "tags")
                             (:file "adp-github")
                             (:file "files")
                             (:file "elements")
                             (:module "adp-elements"
                              :components ((:file "output-file")
                                           (:file "value")
                                           (:file "title")
                                           (:file "text")
                                           (:file "reference")
                                           (:file "table")
                                           (:file "list")
                                           (:file "toc")
                                           (:file "image")
                                           (:file "link")
                                           (:file "quote")
                                           (:file "code-block")
                                           (:file "example")
                                           (:file "description")
                                           (:file "glossary")))))))
