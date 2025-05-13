#ifndef SERVICE_LOCATOR_H
#define SERVICE_LOCATOR_H
#include <typeindex>
#include <unordered_map>

// 使用服务定位器模式（Service Locator）
class ServiceLocator {
public:
	template <typename T>
	static void register_service(T *service) {
		get_services()[typeid(T)] = service;
	}

	template <typename T>
	static T *get_service() {
		auto it = get_services().find(typeid(T));
		if (it != get_services().end()) {
			return static_cast<T *>(it->second);
		}
		return nullptr;
	}

private:
	static std::unordered_map<std::type_index, void *> &get_services() {
		static std::unordered_map<std::type_index, void *> services;
		return services;
	}
};

// servers 模块初始化
// ServiceLocator::register_service<RenderingDeviceInterface>(RenderingDevice::get_singleton());

#endif
