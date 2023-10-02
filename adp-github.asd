
(defsystem "adp-github"
  :author "Héctor Galbis Sanchis"
  :description "ADP extension to generate github markdown files."
  :license "MIT"
  :defsystem-depends-on ("adp")
  :depends-on ("alexandria")
  :components ((:file "package")
               (:module "src")
               (:module "scribble")))
