
#ifndef SERVERS_RENDERING_DEVICE_H
#define SERVERS_RENDERING_DEVICE_H

#include "core/mediator/servers_rendering_device.h"

class RenderingDeviceInterface {
public:
	virtual ~RenderingDeviceInterface() = default;
	virtual void _set_max_fps(int fps) = 0;
};

#endif
