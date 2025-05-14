import inspect
import os
from datetime import datetime

# 设置日志文件路径
LOG_FILE_PATH = r"D:\Work\lzk2022\godot\godot-2025-05-12\godot-4.4.1\godot-4.4.1\custom\build.log"

def ensure_log_directory():
    log_dir = os.path.dirname(LOG_FILE_PATH)
    if log_dir and not os.path.exists(log_dir):
        os.makedirs(log_dir)

def log(level, message):
    # 当前调用日志函数的位置（例如调用log_debug的位置）
    caller_frame = inspect.currentframe().f_back.f_back
    caller_file_path = caller_frame.f_code.co_filename
    caller_line_number = caller_frame.f_lineno
    caller_file_name = os.path.basename(caller_file_path)
    caller_function_name = caller_frame.f_code.co_name

    # 日志函数自身位置（例如log_debug的位置）
    log_func_frame = inspect.currentframe().f_back
    log_func_file_path = log_func_frame.f_code.co_filename
    log_func_line_number = log_func_frame.f_lineno
    log_func_file_name = os.path.basename(log_func_file_path)
    log_func_name = log_func_frame.f_code.co_name

    # 当前时间戳
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # 格式化日志信息
    log_message = (
        f"[{level.upper()} {timestamp}] {caller_file_name}:{caller_line_number} "
        f" - {message} "
    )

    # 输出到控制台
    print(log_message)

    # 确保日志目录存在
    ensure_log_directory()

    # 写入日志文件
    with open(LOG_FILE_PATH, "a", encoding="utf-8") as log_file:
        log_file.write(log_message + "\n")

# 定义不同级别的日志函数
def log_debug(message):
    log("debug", message)

def log_info(message):
    log("info", message)

def log_warning(message):
    log("warning", message)

def log_error(message):
    log("error", message)
