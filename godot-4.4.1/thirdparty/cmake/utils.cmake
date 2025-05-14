# cmake/exclude_files.cmake

# 宏1：根据目录排除源文件和头文件
macro(utils_filter_sources_and_headers_by_dirs SOURCES HEADERS EXCLUDE_DIRS)
	if(EXCLUDE_DIRS)
		# 构建目录排除正则表达式
		string(REPLACE ";" "|" EXCLUDE_PATTERN "${EXCLUDE_DIRS}")
		set(EXCLUDE_REGEX "${CMAKE_CURRENT_SOURCE_DIR}/(${EXCLUDE_PATTERN})/.*\\.(cpp|h|hpp|c|cc|cxx)")

		# 根据目录排除
		list(FILTER ${SOURCES} EXCLUDE REGEX "${EXCLUDE_REGEX}")
		list(FILTER ${HEADERS} EXCLUDE REGEX "${EXCLUDE_REGEX}")
	endif()
endmacro()

# 宏2：根据文件排除源文件和头文件
macro(utils_filter_sources_and_headers_by_files SOURCES HEADERS EXCLUDE_FILES)
	foreach(EXCLUDE_FILE ${EXCLUDE_FILES})
		# 转义特殊字符，防止正则表达式出错
		string(REPLACE "." "\\." EXCLUDE_FILE_REGEX "${EXCLUDE_FILE}")
		string(REPLACE "/" "[/\\\\]" EXCLUDE_FILE_REGEX "${EXCLUDE_FILE_REGEX}")
		set(EXCLUDE_FILE_REGEX "${CMAKE_CURRENT_SOURCE_DIR}/${EXCLUDE_FILE_REGEX}$")

		list(FILTER ${SOURCES} EXCLUDE REGEX "${EXCLUDE_FILE_REGEX}")
		list(FILTER ${HEADERS} EXCLUDE REGEX "${EXCLUDE_FILE_REGEX}")
	endforeach()
endmacro()

# 为每个文件创建source_group
macro(utils_create_source_groups SOURCES HEADERS)
	foreach(FILE ${${SOURCES}} ${${HEADERS}})
		get_filename_component(PARENT_DIR "${FILE}" DIRECTORY)
		file(RELATIVE_PATH GROUP "${CMAKE_CURRENT_SOURCE_DIR}" "${PARENT_DIR}")
		string(REPLACE "/" "\\" GROUP "${GROUP}")
		source_group("${GROUP}" FILES "${FILE}")
	endforeach()
endmacro()

# 定义函数：构建后自动复制目标文件到指定路径
function(utils_copy_output target_name)
	# 定义输出文件路径
	set(output_file_path "${CMAKE_SOURCE_DIR}/build/${target_name}/${target_name}")
	get_filename_component(PARENT_DIR "${CMAKE_SOURCE_DIR}" DIRECTORY)

	# 定义目标路径（复制后的路径）
	set(copy_destination "${PARENT_DIR}/custom/output/${target_name}")

	# 添加自定义命令：构建后自动复制 exe 和 pdb 文件
	add_custom_command(
		TARGET ${target_name} POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy "${output_file_path}.exe" "${copy_destination}.exe"
		COMMAND ${CMAKE_COMMAND} -E copy "${output_file_path}.pdb" "${copy_destination}.pdb"
		COMMENT "Copying ${output_file_path} to ${copy_destination}"
	)
endfunction()

set(macro_thirdparty_include ${CMAKE_SOURCE_DIR}/thirdparty/thirdparty)

# message("thirdparty_include: ${macro_thirdparty_include}")
