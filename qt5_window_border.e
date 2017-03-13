note
	description: "Summary description for {QT5_WINDOW_BORDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QT5_WINDOW_BORDER

inherit
	QT5_ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			flags := 0
		end


feature -- Access

	flags:NATURAL

end
