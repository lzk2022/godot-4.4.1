// core/regex_interface.h
#ifndef REGEX_INTERFACE_H
#define REGEX_INTERFACE_H

#include "core/object/ref_counted.h"

class IRegEx : public RefCounted {
	GDCLASS(IRegEx, RefCounted);

public:
	virtual Error compile(const String &p_pattern, bool p_show_error = true) = 0;
	virtual String sub(const String &p_subject, const String &p_replacement, bool p_all = false, int p_offset = 0, int p_end = -1) const = 0;
	virtual ~IRegEx() = default;

public:
	static constexpr const char *SubClassName = "RegEx";
};

#endif // REGEX_INTERFACE_H
