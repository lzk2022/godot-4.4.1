#ifndef SERVERS_DISPLAY_H
#define SERVERS_DISPLAY_H

#include "core/mediator/service_locator.h"

class IDisplayServer {
public:
	virtual ~IDisplayServer() = default;
	virtual void force_process_and_drop_events() = 0;
};
#endif
