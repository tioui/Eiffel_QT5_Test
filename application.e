note
	description: "qt5_test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_application:QT5_APPLICATION
			l_mem:MEMORY
		do
			create l_application
			create l_mem
			print ("Hello Eiffel World!%N")
			print("Collect peroid: " + l_mem.collection_period.out + "%N")
			print("coalesce peroid: " + l_mem.coalesce_period.out + "%N")
		end

end
