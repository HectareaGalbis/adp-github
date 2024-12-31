
(in-package #:adpgh)

(adp:define-adp-system adp-github)

(adp:define-adp-file scribble)

(defmethod adp:export-content ((system adp-github) files)
  (with-adp-pprint-dispatch
    (process-system system files)))
