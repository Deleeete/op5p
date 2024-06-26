set(target_name "boot")
add_executable(${target_name} boot.S)
set_target_properties(${target_name} PROPERTIES SUFFIX ".elf")

set_target_properties(${target_name} PROPERTIES LINK_FLAGS "-T${CMAKE_CURRENT_LIST_DIR}/boot.lds -no-pie")

# 调用objcopy将生成内容转换为bin
add_custom_command(
    TARGET ${target_name}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ARGS -O binary "${CMAKE_CURRENT_BINARY_DIR}/${target_name}.elf" "${CMAKE_CURRENT_BINARY_DIR}/${target_name}.bin"
    COMMAND python3
        ARGS "${PROJECT_SOURCE_DIR}/build_tools/imager.py"
            "${PROJECT_SOURCE_DIR}/op5p_jammy.img" "0x800800" "${CMAKE_CURRENT_BINARY_DIR}/${target_name}.bin"
)
