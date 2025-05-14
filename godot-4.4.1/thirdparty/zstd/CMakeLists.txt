cmake_minimum_required(VERSION 3.16)
project(zstd C ASM)

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

# Zstd 源文件
set(ZSTD_SOURCES
	common/debug.c
	common/entropy_common.c
	common/error_private.c
	common/fse_decompress.c
	common/pool.c
	common/threading.c
	common/xxhash.c
	common/zstd_common.c
	compress/fse_compress.c
	compress/hist.c
	compress/huf_compress.c
	compress/zstd_compress.c
	compress/zstd_double_fast.c
	compress/zstd_fast.c
	compress/zstd_lazy.c
	compress/zstd_ldm.c
	compress/zstd_opt.c
	compress/zstdmt_compress.c
	compress/zstd_compress_literals.c
	compress/zstd_compress_sequences.c
	compress/zstd_compress_superblock.c
	decompress/huf_decompress.c
	decompress/zstd_ddict.c
	decompress/zstd_decompress_block.c
	decompress/zstd_decompress.c
)

# 根据平台条件添加汇编优化源文件
if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
	list(APPEND ZSTD_SOURCES decompress/huf_decompress_amd64.S)
endif()

# 创建静态库
add_library(zstd STATIC ${ZSTD_SOURCES})

# 设置头文件路径
target_include_directories(zstd PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}/common
)

# 定义宏
target_compile_definitions(zstd PUBLIC ZSTD_STATIC_LINKING_ONLY)
