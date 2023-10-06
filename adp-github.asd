
(defsystem "adp-github"
  :author "Héctor Galbis Sanchis"
  :description "ADP extension to generate github markdown files."
  :license "MIT"
  :defsystem-depends-on ("adp")
  :depends-on ("alexandria")
  :components ((:file "package")
               (:module "src"
                :components ((:file "adp-adv-github")
                             (:file "tags")
                             (:file "adp-github" :depends-on ("tags"))
                             (:file "elements")
                             (:file "pprint-dispatch")
                             (:file "definition-components")
                             (:file "printer" :depends-on ("pprint-dispatch" "definition-components"
                                                                             "adp-github" "elements"))
                             (:file "functions" :depends-on ("adp-github" "elements"))
                             (:file "scribble-functions" :depends-on ("adp-github" "elements"))))
               (:module "scribble")))
