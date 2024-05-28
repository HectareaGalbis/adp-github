
(defsystem "adp-github-docs"
  :author "Héctor Galbis Sanchis"
  :description "Documentation system of ADP-GITHUB"
  :license "MIT"
  :defsystem-depends-on ("adp-github")
  :build-operation "adp-github-op"
  :components ((:module "scribble"
                :components ((:scribble "reference")
                             (:scribble "user-guide")
                             (:scribble "README")))))
