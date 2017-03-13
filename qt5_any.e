note
	description: "Summary description for {QT5_ANY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QT5_ANY

feature {NONE} -- Implementation	

	qt5_object_from_item(a_item:POINTER; a_type_id:INTEGER):detachable QT5_MEMORY_CLASS
			-- Retreive the object of type identified by `a_type_id' using `a_item' as internal pointer
		local
			l_object_list:ITERATION_CURSOR[ANY]
		do
			from
				l_object_list := (create {MEMORY}).objects_instance_of_type (a_type_id).new_cursor
			until
				l_object_list.after or attached Result
			loop
				if
					attached {QT5_MEMORY_CLASS} l_object_list.item as la_item
				and then
					la_item.item = a_item
				then
					Result := la_item
				end
				l_object_list.forth
			end
		end

	string_to_qstring(a_text:READABLE_STRING_GENERAL):QT5_OBJECT
		local
			l_c_string:ANY
			l_pointer:POINTER
		do
			if a_text.is_string_8 then
				l_c_string := a_text.as_string_8.to_c
				create Result.own_from_item(c_string_8_to_qstring($l_c_string, a_text.count))
			else
				l_c_string := a_text.as_string_32.to_c
				create Result.own_from_item(c_string_32_to_qstring($l_c_string, a_text.count))
			end
		end

	qstring_to_string(a_text:QT5_OBJECT):STRING_32
		local
			l_vector:POINTER
			l_count:INTEGER
			l_string_data:MANAGED_POINTER
		do
			l_vector := c_qstring_to_vector(a_text.item)
			l_count := c_qvector_size (l_vector)
			create l_string_data.make ((l_count + 1) * 4)
			l_string_data.item.memory_copy (c_qvector_data(l_vector), l_count * 4)
			c_qvector_delete(l_vector)
			l_string_data.put_natural_32 (0, l_count * 4)
			create Result.make_from_c (l_string_data.item)
		end

feature {NONE} -- External

	c_string_32_to_qstring(a_text:POINTER; a_size:INTEGER):POINTER
			-- Static C++ function to get a QString from a UCS4 string `a_text'
		external
			"C++ inline use <QString>"
		alias
			"new QString(QString::fromUcs4((uint *)$a_text, $a_size))"
		end

	c_string_8_to_qstring(a_text:POINTER; a_size:INTEGER):POINTER
			-- Static C++ function to get a QString from a Latin1 string `a_text'
		external
			"C++ inline use <QString>"
		alias
			"new QString(QString::fromLatin1((char *)$a_text, $a_size))"
		end

	c_qstring_to_vector(a_text:POINTER):POINTER
			-- Static C++ function to get a QVector<unsigned int> from the QString `a_text'
		external
			"C++ inline use <QString> , <QVector>"
		alias
			"new QVector<unsigned int>(((QString *)$a_text)->toUcs4())"
		end

	c_qvector_data(a_vector:POINTER):POINTER
			-- Static C++ function to get the internal data of a QVector<unsigned int>
		external
			"C++ inline use <QVector>"
		alias
			"((QVector<unsigned int> *)$a_vector)->data()"
		end

	c_qvector_size(a_vector:POINTER):INTEGER
			-- Static C++ function to get the number of element in a QVector<unsigned int>
		external
			"C++ inline use <QVector>"
		alias
			"((QVector<unsigned int> *)$a_vector)->size()"
		end

	c_qvector_delete(a_vector:POINTER)
			-- Static C++ function to free a QVector<unsigned int>
		external
			"C++ inline use <QVector>"
		alias
			"delete ((QVector<unsigned int> *)$a_vector)"
		end

end
