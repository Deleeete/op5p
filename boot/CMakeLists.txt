set(target_name "boot")
add_executable(${target_name} boot.S)
set_target_properties(${target_name} PROPERTIES SUFFIX ".elf")

set_target_properties(${target_name} PROPERTIES LINK_FLAGS "-T${CMAKE_CURRENT_LIST_DIR}/boot.lds -no-pie")

# 调用objcopy将生成内容转换为bin
add_custom_command(
    TARGET ${target_name}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ARGS -O binary "${CMAKE_CURRENT_BINARY_DIR}/${target_name}.elf" "${CMAKE_CURRENT_BINARY_DIR}/${target_name}.bin"
    # dd if=/dev/urandom of=/mypart/aaa bs=1024 seek=15000 count=15000
    COMMAND dd
        ARGS if="${CMAKE_CURRENT_BINARY_DIR}/${target_name}.bin" of="${PROJECT_SOURCE_DIR}/op5p_jammy.img" bs=1 seek=0x800800
)
