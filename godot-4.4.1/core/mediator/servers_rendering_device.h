
#ifndef SERVERS_RENDERING_DEVICE_H
#define SERVERS_RENDERING_DEVICE_H
class RenderingDeviceInterface {
public:
	virtual ~RenderingDeviceInterface() {}
	virtual void _set_max_fps(int fps) = 0;
};

#endif
