
(in-package #:adp-github)


;; ------ cell ------
(defclass cell ()
  ((elements :initarg :elements))
  (:documentation
   "Represents a cell in a table."))

(adp:defun cell (&rest elements)
  "The cells are the components of a row. All the elements will be inserted inside a cell table."
  (make-instance 'cell :elements elements))

(defmethod print-element (stream (element cell))
  (format stream "<td>~{~/adpgh:format-element-html/~}</td>" (slot-value element 'elements)))


;; ------ row ------
(defclass row ()
  ((cells :initarg :cells))
  (:documentation
   "Represents a row of cells in a table."))

(adp:defun row (&rest cells)
  "The rows are the components of a table. The CELLS must be objects of type cell."
  (loop for cell in cells
        when (not (typep cell 'cell))
          do (error "Each cell of a row must be a cell."))
  (make-instance 'row :cells cells))

(defmethod print-element (stream (element row))
  (format stream "<tr>~%~{~/adpgh:format-element/~}</tr>" (slot-value element 'cells)))


;; ------ table ------
(defclass table ()
  ((rows :initarg :rows))
  (:documentation
   "Represents a table."))

(adp:defun table (&rest elements)
  "Inserts a table. The elements must be rows."
  (assert (> (length elements) 0))
  (let ((num-cells (length (slot-value (car elements) 'cells))))
    (loop for element in elements
          for row-num-cells = (length (slot-value element 'cells))
          when (not (eql num-cells row-num-cells))
            do (error "Every row must have the same number of elements.")
          when (not (typep element 'row))
            do (error "Each element of a table must be a row.")))
  (make-instance 'table :rows elements))

(defmethod print-element (stream (element table))
  (format stream "<table>~%~{~/adpgh:format-element/~}</table>" (slot-value element 'rows)))
