note
	description: "Summary description for {QT5_PAINT_DEVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QT5_PAINT_DEVICE

inherit
	QT5_MEMORY_CLASS

feature {NONE} -- Externals

	c_destructor(a_current:POINTER)
			-- Internal C++ object destructor
		external
			"C++ inline use <QPaintDevice>"
		alias
			"delete (QPaintDevice *)$a_current"
		end
end
