note
	description: "Summary description for {QT5_ABSTRACT_BUTTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QT5_ABSTRACT_BUTTON

inherit
	QT5_WIDGET
		redefine
			c_destructor
		end


feature {NONE} -- Externals

	c_destructor(a_current:POINTER)
			-- Internal C++ object destructor
		external
			"C++ inline use <QAbstractButton>"
		alias
			"delete (QAbstractButton *)$a_current"
		end

end
