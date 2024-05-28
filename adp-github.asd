
(defsystem "adp-github"
  :author "Héctor Galbis Sanchis"
  :description "ADP extension to generate github markdown files."
  :license "MIT"
  :depends-on ("alexandria" "closer-mop" "adp" "trivial-arguments")
  :components ((:file "src/package")
               (:module "src"
                :components ((:file "tags")
                             (:file "pprint-dispatch")
                             (:file "adp-github" :depends-on ("tags" "pprint-dispatch"))
                             (:file "elements" :depends-on ("tags"))
                             (:file "printer" :depends-on ("adp-github" "elements" "tags"))
                             (:file "functions" :depends-on ("adp-github" "elements" "tags")))
                :depends-on ("src/package"))))
