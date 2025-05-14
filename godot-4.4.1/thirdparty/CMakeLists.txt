cmake_minimum_required(VERSION 3.10)

# 设置项目名称
project(thirdparty)

# 设置 C++ 标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# MSVC 设置 UTF-8 编译选项
if(MSVC)
	add_compile_options(/utf-8)
	add_compile_options(/Zc:__cplusplus)

	# 禁用所有警告
	add_compile_options(/w)

	# 禁用编译器启动标识信息
	add_compile_options(/nologo)

	# 编译器无法处理过大的对象文件
	add_compile_options(/bigobj)

	# 强制设置 MSVC 的运行时库为静态链接的 Release 模式（/MT）
	set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:>")

	# 关闭迭代器调试
	add_definitions(-D_ITERATOR_DEBUG_LEVEL=0)

	# 强制所有模式（包括Debug）使用 Release 运行时库
	foreach(flag_var
		CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
		CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE)
		if(${flag_var} MATCHES "/MD")
			string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
		endif()

		if(${flag_var} MATCHES "/MDd")
			string(REGEX REPLACE "/MDd" "/MT" ${flag_var} "${${flag_var}}")
		endif()

		if(${flag_var} MATCHES "/MTd")
			string(REGEX REPLACE "/MTd" "/MT" ${flag_var} "${${flag_var}}")
		endif()
	endforeach()
endif()

# 添加子目录
add_subdirectory(clipper2)
add_subdirectory(brotli)
add_subdirectory(minizip)
add_subdirectory(zlib)
add_subdirectory(zstd)
add_subdirectory(misc)
add_subdirectory(amd-fsr2)
add_subdirectory(spirv-reflect)


