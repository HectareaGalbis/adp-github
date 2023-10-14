
(defsystem "adp-github"
  :author "Héctor Galbis Sanchis"
  :description "ADP extension to generate github markdown files."
  :license "MIT"
  :defsystem-depends-on ("adp")
  :depends-on ("alexandria" "closer-mop")
  :components ((:file "package")
               (:module "src"
                :components ((:file "adp-adv-github")
                             (:file "tags")
                             (:file "adp-github" :depends-on ("tags"))
                             (:file "elements")
                             (:file "pprint-dispatch")
                             (:file "definition-components")
                             (:file "printer" :depends-on ("pprint-dispatch" "definition-components"
                                                                             "adp-github" "elements" "tags"))
                             (:file "functions" :depends-on ("adp-github" "elements" "adp-adv-github" "tags"))))
               (:module "scribble"
                :components ((:scribble "reference")
                             (:scribble "user-guide")))
               (:scribble "README" :depends-on ("src"))))
