note
	description: "Summary description for {QT5_CORE_APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QT5_CORE_APPLICATION

inherit
	QT5_OBJECT
		rename
			c_constructor as c_constructor_object
		redefine
			default_create,
			c_destructor
		end

create
	default_create,
	make_with_arguments

feature {NONE} -- Initialization

	default_create
		local
			l_arguments:ARGUMENTS
		do
			create l_arguments
			make_with_arguments(l_arguments.argument_array)
		end

	make_with_arguments(a_arguments:ARRAY[STRING_8])
		require
			At_Least_One_Arguments: a_arguments.count >= 1
		local
			l_c_array:ANY
		do
			arguments := a_arguments.twin
			arguments_count := arguments.count
			l_c_array := arguments.to_c
			item := c_constructor(arguments_count, $l_c_array)
		ensure
			Exists: exists
		end

feature -- Access

	arguments: ARRAY[STRING_8]
			-- The arguments passing to the application (at least 1 element, AKA command name)

	arguments_count:INTEGER
			-- The number of element in `arguments'

feature {NONE} -- Implementation

	manage_event_filter(a_object, a_event:POINTER; a_type_id:INTEGER)
			-- Manage the events comming from the C++ side
		do
			print("Yéé, Un événement")
		end

feature {NONE} -- Externals

	c_constructor(a_argc:INTEGER; a_argv:POINTER):POINTER
			-- Internal C++ object constructor
		external
			"C++ inline use <QCoreApplication>"
		alias
			"new QCoreApplication($a_argc, (char **) $a_argv)"
		end

	c_destructor(a_current:POINTER)
			-- Internal C++ object destructor
		external
			"C++ inline use <QCoreApplication>"
		alias
			"delete (QCoreApplication *)$a_current"
		end

invariant
	Arguments_Count_Valid: arguments_count = arguments.count
end
