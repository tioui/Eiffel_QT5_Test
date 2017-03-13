note
	description: "Summary description for {QT5_APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QT5_APPLICATION

inherit
	QT5_GUI_APPLICATION
		redefine
			c_constructor,
			c_destructor
		end

create
	default_create,
	make_with_arguments


feature {NONE} -- Externals

	c_constructor(a_argc:INTEGER; a_argv:POINTER):POINTER
			-- Internal C++ object constructor
		external
			"C++ inline use <QApplication>"
		alias
			"new QApplication($a_argc, (char **) $a_argv)"
		end

	c_destructor(a_current:POINTER)
			-- Internal C++ object destructor
		external
			"C++ inline use <QApplication>"
		alias
			"delete (QApplication *)$a_current"
		end

end
