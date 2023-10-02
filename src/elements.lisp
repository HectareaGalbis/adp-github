
(in-package #:adp-gh)


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


;; ----- text reference -----
(defclass text-reference (tagged-element text-subelement-type)
  ((tag :initarg :tag
        :reader text-reference-tag
        :type tag))
  (:documentation
   "Represent a text reference element."))

(defclass header-ref (text-reference) ()
  (:documentation
   "Represent a header reference element."))

(defclass symbol-ref (text-reference) ()
  (:documentation
   "Represent a symbol reference element."))

(defclass function-ref (text-reference) ()
  (:documentation
   "Represent a function reference element."))

(defclass type-ref (text-reference) ()
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
  ((items :initarg :item
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
             :type vector)))

(defclass bold (text-decorator) ()
  (:documentation
   "Represent a bold element."))

(defclass italic (text-decorator) ()
  (:documentation
   "Represent a italic element."))

(defclass emphasis (text-decorator) ()
  (:documentation
   "Represent a emphasis element."))

(defclass inline (text-decorator) ()
  (:documentation
   "Represents an inline element."))


;; ------ link ------
(defclass link ()
  ((name :initarg :name
         :reader link-name
         :type string)
   (address :initarg :address
            :reader link-address
            :type string))
  (:documentation
   "Represents a web link."))


;; ------ references ------
(defclass header-reference ()
  ((tag :initarg tag
        :reader header-reference-tag
        :type symbol))
  (:documentation
   "Represents a header reference."))

(defclass function-reference ()
  ((tag :initarg tag
        :reader function-reference-tag
        :type symbol))
  (:documentation
   "Represents a function reference."))

(defclass variable-reference ()
  ((tag :initarg tag
        :reader variable-reference-tag
        :type symbol))
  (:documentation
   "Represents a variable reference."))

(defclass type-reference ()
  ((tag :initarg tag
        :reader type-reference-tag
        :type symbol))
  (:documentation
   "Represents a type reference."))


;; ------ quote ------
(defclass quote ()
  ((elements :initarg :elements
             :reader quote-elements
             :type list))
  (:documentation
   "Represents a quote."))


;; ------ code block ------
(defclass code-block ()
  ((expressions :initarg :expressions
                :reader code-block-expressions
                :type list))
  (:documentation
   "Represents a code block."))


;; ------ verbatim code block ------
(defclass verbatim-code-block ()
  ((elements :initarg :elements
             :reader verbatim-code-block-elements
             :type list))
  (:documentation
   "Represetns a verbatim code block."))


;; ------ code example ------
(defclass example ()
  ((expressions :initarg :expressions
                :reader example-expressions
                :type list))
  (:documentation
   "Represents an example."))
