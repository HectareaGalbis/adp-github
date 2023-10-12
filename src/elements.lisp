
(in-package #:adpgh-core)


;; ----- header -----
(defclass header-type ()
  ((elements :initarg :elements
             :reader header-elements
	     :type list)
   (user-tag-p :initarg :user-tag-p
               :reader header-user-tag-p
	       :type boolean)
   (tag :initarg :tag
        :reader header-tag
	:type tag)
   (target-location :initarg :target-location
                    :reader header-target-location
                    :type pathname))
  (:documentation
   "Represents a header type element."))

(defclass header (header-type) ()
  (:documentation
   "Represent a header element."))

(defclass subheader (header-type) ()
  (:documentation
   "Represent a subheader element."))

(defclass subsubheader (header-type) ()
  (:documentation
   "Represent a subsubheader element."))


;; ------ text ------
(defclass text ()
  ((elements :initarg :elements
             :reader text-elements
             :type list))
  (:documentation
   "Represents a text element."))

;; ------ text reference ------
(defclass text-reference ()
  ((tag :initarg :tag
        :reader text-reference-tag
        :type tag))
  (:documentation
   "Represent a text reference element."))

(defclass header-reference (text-reference)
  ((text-elements :initarg :text-elements
                  :initform nil
                  :reader header-ref-text-elements
                  :type list))
  (:documentation
   "Represent a header reference element."))

(defclass symbol-reference (text-reference) ()
  (:documentation
   "Represents a symbol reference."))

;; Quizas no hagan falta estas clases

(defclass variable-reference (symbol-reference) ()
  (:documentation
   "Represent a variable reference element."))

(defclass function-reference (symbol-reference) ()
  (:documentation
   "Represent a function reference element."))

(defclass type-reference (symbol-reference) ()
  (:documentation
   "Represent a type reference element."))


;; ------ table ------
(defclass cell ()
  ((elements :initarg :elements
             :accessor cell-elements
             :type list))
  (:documentation
   "Represents a cell in a table."))

(defclass row ()
  ((cells :initarg :cells
          :accessor row-cells
          :type list))
  (:documentation
   "Represents a row of cells in a table."))

(defclass table ()
  ((rows :initarg :rows
         :accessor table-rows
         :type vector))
  (:documentation
   "Represents a table."))


;; ------ itemize ------
(defclass item ()
  ((elements :initarg :elements
             :reader item-elements
             :type list))
  (:documentation
   "Represents an item in a list of items."))

(defclass itemize ()
  ((items :initarg :items
          :reader itemize-items
          :type list)))

(defclass enumerate ()
  ((items :initarg :items
          :reader enumerate-items
          :type list)))


;; ------ table of contents ------
(defclass table-of-contents () ()
  (:documentation
   "Represents a table of contents."))

(defclass mini-table-of-contents () ()
  (:documentation
   "Represents a mini table of contents."))

(defclass table-of-functions () ()
  (:documentation
   "Represents a table of functions."))

(defclass table-of-symbols () ()
  (:documentation
   "Represents a table of symbols."))

(defclass table-of-types () ()
  (:documentation
   "Represents a table of types."))


;; ------ image ------
(defclass image ()
  ((path :initarg :path
         :reader image-path
         :type (or string pathname))
   (alt-text :initarg :alt-text
             :reader image-alt-text
             :type string)
   (scale :initarg :scale
          :reader image-scale
          :type real))
  (:documentation
   "Represents an image."))


;; ------ text enrichment ------
(defclass text-decorator ()
  ((elements :initarg :elements
             :reader text-decorator-elements
             :type list)))

(defclass bold (text-decorator) ()
  (:documentation
   "Represent a bold element."))

(defclass italic (text-decorator) ()
  (:documentation
   "Represent a italic element."))

(defclass emphasis (text-decorator) ()
  (:documentation
   "Represent a emphasis element."))

(defclass inline-code (text-decorator) ()
  (:documentation
   "Represents an inline element."))


;; ------ link ------
(defclass link ()
  ((elements :initarg :elements
         :reader link-elements
         :type list)
   (address :initarg :address
            :reader link-address
            :type string))
  (:documentation
   "Represents a web link."))


;; ------ quote ------
(defclass quoted ()
  ((elements :initarg :elements
             :reader quote-elements
             :type list))
  (:documentation
   "Represents a quote."))


;; ------ code block ------
(defclass code-of-block ()
  ((expressions :initarg :expressions
                :reader code-block-expressions
                :type list))
  (:documentation
   "Represents a code block."))


;; ------ verbatim code block ------
(defclass verbatim-code-of-block ()
  ((lang :initarg :lang
         :reader verbatim-code-block-lang
         :type string)
   (elements :initarg :elements
             :reader verbatim-code-block-elements
             :type list))
  (:documentation
   "Represetns a verbatim code block."))


;; ------ code example ------
(defclass example ()
  ((expressions :initarg :expressions
                :reader example-expressions
                :type list)
   (output :initarg :output
           :reader example-output
           :type string)
   (results :initarg :results
            :reader example-results
            :type list))
  (:documentation
   "Represents an example."))


;; ------ definitions ------
(defclass definition ()
  ((expression :initarg :expression
               :reader definition-expression))
  (:documentation
   "Represetns a definition."))

(defclass tagged-definition (definition)
  ((tag :initarg :tag
        :reader definition-tag
        :type tag)
   (target-location :initarg :target-location
                    :reader definition-target-location
                    :type pathname))
  (:documentation
   "Represents a tagged definition."))

(defclass defclass-definition (tagged-definition) ()
  (:documentation
   "Represents a class definition."))

(defclass defconstant-definition (tagged-definition) ()
  (:documentation
   "Represents a constant definition."))

(defclass defgeneric-definition (tagged-definition) ()
  (:documentation
   "Represents a generic function definition."))

(defclass define-compiler-macro-definition (definition) ()
  (:documentation
   "Represents a compiler macro definition."))

(defclass define-condition-definition (tagged-definition) ()
  (:documentation
   "Represents a condition definition."))

(defclass define-method-combination-definition (definition) ()
  (:documentation
   "Represents a method combination definition."))

(defclass define-modify-macro-definition (tagged-definition) ()
  (:documentation
   "Represents a modify macro definition."))

(defclass define-setf-expander-definition (definition) ()
  (:documentation
   "Represents a setf expander definition."))

(defclass define-symbol-macro-definition (tagged-definition) ()
  (:documentation
   "Represents a symbol macro definition."))

(defclass defmacro-definition (tagged-definition) ()
  (:documentation
   "Represents a macro definition."))

(defclass defmethod-definition (definition) ()
  (:documentation
   "Represents a defmethod definition."))

(defclass defpackage-definition (definition) ()
  (:documentation
   "Represents a package definition."))

(defclass defparameter-definition (tagged-definition) ()
  (:documentation
   "Represents a parameter definition."))

(defclass defsetf-definition (definition) ()
  (:documentation
   "Represents a setf definition."))

(defclass defstruct-definition (tagged-definition) ()
  (:documentation
   "Represents a struct definition."))

(defclass deftype-definition (tagged-definition) ()
  (:documentation
   "Represents a type definition."))

(defclass defun-definition (tagged-definition) ()
  (:documentation
   "Represents a function definition."))

(defclass defvar-definition (tagged-definition) ()
  (:documentation
   "Represents a variable definition."))
