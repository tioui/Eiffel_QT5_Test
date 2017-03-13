note
	description: "Summary description for {QT5_PUSH_BUTTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QT5_PUSH_BUTTON

inherit
	QT5_ABSTRACT_BUTTON
		redefine
			c_constructor,
			c_constructor_with_parent,
			c_destructor
		end

create
	default_create,
	make_with_parent

feature {NONE} -- Initialization

	make_with_text(a_text:READABLE_STRING_GENERAL)
			-- Initialization of `Current' displaying `a_text'
		do
			
		end

feature {NONE} -- Externals

	c_constructor:POINTER
			-- Internal C++ object constructor
		external
			"C++ inline use <QPushButton>"
		alias
			"new QPushButton()"
		end

	c_constructor_with_parent(a_parent:POINTER):POINTER
			-- Internal C++ object constructor using the C++ pointer `a_parent' as `Current' parent
		external
			"C++ inline use <QPushButton>"
		alias
			"new QPushButton((QPushButton *)$a_parent)"
		end

	c_destructor(a_current:POINTER)
			-- Internal C++ object destructor
		external
			"C++ inline use <QPushButton>"
		alias
			"delete (QPushButton *)$a_current"
		end

end
