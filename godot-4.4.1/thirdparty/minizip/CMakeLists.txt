cmake_minimum_required(VERSION 3.16)
project(minizip C)

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

# 创建静态库
add_library(minizip STATIC
	ioapi.c
	unzip.c
	zip.c
)

# 当前路径上一级的 zlib 头文件和库路径
set(ZLIB_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../zlib")
set(ZLIB_LIB_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../zlib/build")

# 引入 Minizip 和 zlib 的头文件路径
target_include_directories(minizip PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
	${ZLIB_INCLUDE_DIR}
)

# 链接 zlib 静态库
target_link_directories(minizip PUBLIC ${ZLIB_LIB_DIR})

target_link_libraries(minizip PUBLIC zlib)
