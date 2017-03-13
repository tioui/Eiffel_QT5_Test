note
	description: "Summary description for {QT5_MEMORY_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QT5_MEMORY_CLASS

inherit
	QT5_ANY
	DISPOSABLE

feature -- Status report

	exists:BOOLEAN
			--	`Current' is a valid Qt5 memory object
		do
			Result := not item.is_default_pointer
		end

feature {QT5_ANY} -- Implementation

	item:POINTER
			-- The internal C++ pointer of `Current'

feature {NONE} -- Implementation

	dispose
			-- <Precursor>
		do
			if not item.is_default_pointer then
				c_destructor(item)
				create item
			end
		end


feature {NONE} -- Externals

	c_destructor(a_current:POINTER)
			-- Internal C++ object destructor
		deferred
		end
end
