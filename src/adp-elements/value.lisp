
(in-package #:adp-github)

(defun escape-md-text (text)
  "Escapes sensitive markdown characters."
  (let ((punctuation-chars '(#\! #\" #\# #\$ #\% #\& #\' #\( #\) #\* #\+ #\, #\- #\. #\/ #\: #\; #\< #\= #\> #\? #\@ #\[ #\\ #\] #\^ #\_ #\` #\{ #\| #\} #\~))
	(fixed-text (make-array (length text) :adjustable t :fill-pointer 0 :element-type 'character)))
    (loop for char across text
	  when (member char punctuation-chars :test #'char=)
	    do (vector-push-extend #\\ fixed-text)
	  do (vector-push-extend char fixed-text))
    (values fixed-text)))

(defun escape-html-text (text)
  "Escapes sensitive html characters."
  (let ((punctuation-chars '((#\< . "&#60;")
			     (#\> . "&#62;")
                             (#\Newline . "<br>")))
	(fixed-text (make-array (length text) :adjustable t :fill-pointer 0 :element-type 'character)))
    (with-output-to-string (stream fixed-text)
      (loop for char across text
	    for code = (cdr (assoc char punctuation-chars))
	    if code
	      do (princ code stream)
	    else
	      do (princ char stream)))    
    (values fixed-text)))

(defun escape-text (text)
  "Escapes the text for the current context."
  (case *print-context*
    (:md (escape-md-text text))
    (:html (escape-html-text text))
    (t text)))

(defmethod print-element (stream (element string))
  "By default, strings are princ-ed."
  (princ (escape-text (princ-to-string element)) stream))

(defmethod print-element (stream element)
  "The rest of elements respect the print variables."
  (princ (escape-text (write-to-string element)) stream))
