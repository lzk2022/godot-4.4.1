#ifndef SCENE_NODE_H
#define SCENE_NODE_H

#include "core/object/object.h"

class INode : public Object {
	GDCLASS(INode, Object);

public:
	virtual ~INode() = default;

public:
	static constexpr const char *SubClassName = "Node";
};

#endif
