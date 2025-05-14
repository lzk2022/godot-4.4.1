set(LIB_NAME zstd)

project(${LIB_NAME} C ASM)

# file(GLOB_RECURSE SOURCES "*.cpp")
file(GLOB_RECURSE HEADERS "*.h")
set(SOURCES
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
	list(APPEND SOURCES decompress/huf_decompress_amd64.S)
endif()

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
	${CMAKE_CURRENT_SOURCE_DIR}/common
)

# 定义宏
target_compile_definitions(${LIB_NAME} PUBLIC ZSTD_STATIC_LINKING_ONLY)
