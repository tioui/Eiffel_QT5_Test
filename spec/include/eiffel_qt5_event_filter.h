#ifndef EIFFEL_QT5_EVENT_FILTER_H
#define EIFFEL_QT5_EVENT_FILTER_H
#include "QObject"
#include "eif_plug.h"
#include "eif_cecil.h"
#include "eif_hector.h"

void set_eiffel_qt5_application(EIF_OBJECT qt5_application);

void unset_eiffel_qt5_application(void);

class eiffel_qt5_event_filter : public QObject
{
	public:
		eiffel_qt5_event_filter(int a_type_id);
		~eiffel_qt5_event_filter();
	private:
		int type_id;
	protected:
	    bool event_filter(QObject *a_object, QEvent *a_event);
};

#endif
