note
	description: "Summary description for {QT5_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QT5_OBJECT

inherit
	QT5_MEMORY_CLASS
		redefine
			default_create,
			c_destructor
		end

create
	default_create,
	make_with_parent

create {QT5_ANY}
	own_from_item

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			item := c_constructor
		ensure then
			Exists: exists
		end

	make_with_parent(a_parent:QT5_OBJECT)
			-- Initialization of `Current' using `a_parent' as `parent'
		do
			item := c_constructor_with_parent (a_parent.item)
			parent_implementation := a_parent
		ensure
			Exists: exists
		end

	own_from_item(a_item:POINTER)
			-- Initialization of `Current' using directly an already
			-- initialized C++ pointer
		require
			Exists: not a_item.is_default_pointer
		do
			item := a_item
		ensure
			Exists: exists
		end

feature -- Access

	parent:detachable QT5_OBJECT
			-- The parent of `Current'
		require
			Current_Exists: exists
		do
			if attached {QT5_OBJECT} get_object_from_item(c_get_parent (item), parent_implementation) as la_object then
				Result := la_object
			end
			if attached parent_implementation and Result /= parent_implementation then
				parent_implementation := Result
			end
		end

	set_parent(a_parent:detachable QT5_OBJECT)
			-- Assign `parent' with the value of `a_parent'
		require
			Current_Exists: exists
			Parent_Exists: attached a_parent as la_parent implies la_parent.exists
		do
			if attached a_parent as la_parent then
				c_set_parent(item, la_parent.item)
			else
				c_set_parent(item, create {POINTER})
			end
			parent_implementation := a_parent
		end

feature {NONE} -- Implementation

	parent_implementation:detachable QT5_OBJECT
			-- Then internal value of `parent'

	get_object_from_item(a_item:POINTER; a_should_be:detachable QT5_MEMORY_CLASS):detachable QT5_MEMORY_CLASS
			-- Retreive the {QT5_OBJECT} that has the internal C++ pointer `a_item'.
			-- It should be the object `a_should_be', but it is possible that the internal library has
			-- change it.
		do
			if not a_item.is_default_pointer then
				if attached a_should_be as la_should_be then
					if la_should_be.item = a_item then
						Result := la_should_be
					end
				end
				if not attached Result then
					Result := qt5_object_from_item (a_item, ({QT5_MEMORY_CLASS}).type_id)
				end
			end
		end

feature {NONE} -- Externals

	c_constructor:POINTER
			-- Internal C++ object constructor
		external
			"C++ inline use <QObject>"
		alias
			"new QObject()"
		end

	c_constructor_with_parent(a_parent:POINTER):POINTER
			-- Internal C++ object constructor using the C++ pointer `a_parent' as `Current' parent
		external
			"C++ inline use <QObject>"
		alias
			"new QObject((QObject *)$a_parent)"
		end

	c_destructor(a_current:POINTER)
			-- Internal C++ object destructor
		external
			"C++ inline use <QObject>"
		alias
			"delete (QObject *)$a_current"
		end

	c_get_parent(a_current:POINTER):POINTER
			-- Internal C++ function to retreive the parent of `a_current'
		external
			"C++ inline use <QObject>"
		alias
			"((QObject *)$a_current)->parent()"
		end

	c_set_parent(a_current, a_parent:POINTER)
			-- Internal C++ function to set `a_parent' of `a_current'
		external
			"C++ inline use <QObject>"
		alias
			"((QObject *)$a_current)->setParent((QObject *)$a_parent)"
		end

end
