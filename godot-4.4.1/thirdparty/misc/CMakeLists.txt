set(LIB_NAME misc)

project(${LIB_NAME})

# file(GLOB_RECURSE SOURCES "*.cpp")
file(GLOB_RECURSE HEADERS "*.h")
set(SOURCES

	# core
	fastlz.c
	r128.c
	smaz.c
	pcg.cpp
	smolv.cpp

	# scene
	mikktspace.c
	qoa.c
)

# 要排除的目录
set(EXCLUDE_DIRS
)

# 要排除的文件列表
set(EXCLUDE_FILES
)

# include(${CMAKE_SOURCE_DIR}/cmake/utils.cmake)
# utils_filter_sources_and_headers_by_dirs(SOURCES HEADERS "${EXCLUDE_DIRS}")
# utils_filter_sources_and_headers_by_files(SOURCES HEADERS "${EXCLUDE_FILES}")
# utils_create_source_groups(SOURCES HEADERS)

# 添加库源文件
add_library(${LIB_NAME} STATIC
	${HEADERS}
	${SOURCES}
)

# 链接 Windows API 所需的库
target_link_libraries(${LIB_NAME} PRIVATE
)

# 包含头文件目录
target_include_directories(${LIB_NAME} PUBLIC
	${CMAKE_CURRENT_SOURCE_DIR}/
)
