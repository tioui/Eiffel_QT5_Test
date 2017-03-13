/* Event manager for the Eiffel QT5 library. 	*
 * Author: Louis Marchand		*
 * Date: Sun, 22 Jan 2017 20:47:58 +0000			*
 * Version: 0.1				*/

#include "eiffel_qt5_event_filter.h"

EIF_OBJECT eiffel_qt5_application;

/**
 * Remove the Eiffel object {QT5_CORE_APPLICATION} from `eiffel_qt5_application'
 */
void unset_eiffel_qt5_application()
{
    eif_wean(eiffel_qt5_application);
    eiffel_qt5_application = NULL;
}

/**
 * Set the correct value for the callback system
 *
 * @param qt5_application The Eiffel object that will receive the callback
 */
void set_eiffel_qt5_application(EIF_OBJECT qt5_application)
{
    eiffel_qt5_application = eif_adopt(qt5_application);
}

/*
 * Constructor of the Eiffel Qt5 event filter
 *
 * @param a_type_id The Internal eiffel identificator of the object
 */
eiffel_qt5_event_filter::eiffel_qt5_event_filter(int a_type_id) : QObject(0)
{
	this->type_id = a_type_id;
}

/*
 * Destructor of the Eiffel Qt5 event filter
 */
eiffel_qt5_event_filter::~eiffel_qt5_event_filter()
{
}

/* 
 * Function that launch the event management on the Eiffel Side
 * 
 * @param a_object The object that the event is affecting
 * @param a_event The event that is affecting the object
 */

bool eiffel_qt5_event_filter::event_filter(QObject *a_object, QEvent *a_event)
{
	EIF_PROCEDURE ep;
    EIF_TYPE_ID tid;
    if (eiffel_qt5_application){
        tid = eif_type(eiffel_qt5_application);
        if (tid != EIF_NO_TYPE){
            ep = eif_procedure ("manage_event_filter", tid);
            if(ep != NULL){
                (ep) (eif_access(eiffel_qt5_application), a_object, a_event,
						this->type_id);
            }else{
                eif_panic(
                        "Feature `manage_event_filter' of class"
                        "{QT5_CORE_APPLICATION} (or ancestor) is not visible"
                        );
            }
        }else{
            eif_panic(
					"Class {QT5_CORE_APPLICATION} (or ancestor) is not "
					"visible"
					);
        }
    }else{
        eif_panic(
				"The {QT5_CORE_APPLICATION} (or ancestor) object is not "
				"initialized."
				);
    }
    return false;
}
