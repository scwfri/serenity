include(${CMAKE_CURRENT_LIST_DIR}/common_compile_options.cmake)

add_compile_options(-Wno-maybe-uninitialized)
add_compile_options(-Wno-shorten-64-to-32)
add_compile_options(-fsigned-char)
add_compile_options(-ggnu-pubnames)
if (NOT WIN32)
    add_compile_options(-fPIC)
endif()

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_compile_options(-ggdb3)
    add_compile_options(-Og)
else()
    add_compile_options(-O2)
    add_compile_options(-g1)
endif()

function(add_linker_flag_if_supported flag)
    include(CheckLinkerFlag)

    check_linker_flag(CXX ${flag} LAGOM_LINKER_SUPPORTS_${flag})
    if (${LAGOM_LINKER_SUPPORTS_${flag}})
        add_link_options(${flag})
    endif()
endfunction()

add_linker_flag_if_supported(LINKER:--gdb-index)

if (NOT ENABLE_FUZZERS)
    add_linker_flag_if_supported(LINKER:-Bsymbolic-non-weak-functions)
endif()
