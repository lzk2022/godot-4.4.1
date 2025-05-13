#ifndef SERVERS_RENDERING_H
#define SERVERS_RENDERING_H
#include "core/mediator/service_locator.h"

class IRenderingServer {
public:
	virtual ~IRenderingServer() = default;
	virtual void sync() = 0;
};

#endif
