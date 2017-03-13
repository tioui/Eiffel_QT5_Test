note
	description: "Summary description for {QT5_WIDGET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QT5_WIDGET

inherit
	QT5_OBJECT
		redefine
			c_destructor,
			c_constructor_with_parent,
			c_constructor,
			default_create,
			make_with_parent
		end

	QT5_PAINT_DEVICE
		redefine
			c_destructor,
			default_create
		end

create
	default_create,
	make_with_parent,
	make_with_border

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			item := c_constructor
		end

	make_with_parent(a_parent:QT5_WIDGET)
			-- Initialization of `Current' using `a_parent' as `parent'
		do
			item := c_constructor_with_parent (a_parent.item)
			parent_implementation := a_parent
		end

	make_with_border(a_border:QT5_WINDOW_BORDER)
			-- Initialization of `Current' as top
			-- widget (window frame) using `a_border'
			-- to indicate the border style
		do
			item := c_constructor_with_flags (a_border.flags)
		ensure
			Exists: exists
		end

feature {NONE} -- Externals

	c_destructor(a_current:POINTER)
			-- Internal C++ object destructor
		external
			"C++ inline use <QWidget>"
		alias
			"delete (QWidget *)$a_current"
		end

	c_constructor:POINTER
			-- Internal C++ object constructor
		external
			"C++ inline use <QWidget>"
		alias
			"new QWidget()"
		end

	c_constructor_with_parent(a_parent:POINTER):POINTER
			-- Internal C++ object constructor
		external
			"C++ inline use <QWidget>"
		alias
			"new QWidget((QWidget *)$a_parent)"
		end

	c_constructor_with_flags(a_flags:NATURAL):POINTER
			-- Internal C++ object constructor
			-- for top widget (window frame)
			-- using `a_flags' to indicate the border style
		external
			"C++ inline use <QWidget>"
		alias
			"new QWidget(0, $a_flags)"
		end
end
