cmake_minimum_required(VERSION 3.30...4.0)

project(XXXXXXXXXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_SCAN_FOR_MODULES OFF)


add_library(XXXXXXXXXX-lib STATIC)
add_library(XXXXXXXXXX-lib::XXXXXXXXXX-lib ALIAS XXXXXXXXXX-lib)

set(XXXXXXXXXX_LIB_SRC
    xxx.cpp)

list(TRANSFORM INCPLOT_LIB_SRC PREPEND ${CMAKE_CURRENT_SOURCE_DIR}/src/)

target_sources(XXXXXXXXXX-lib PRIVATE ${INCPLOT_LIB_SRC})
target_sources(XXXXXXXXXX-lib
    PUBLIC
        FILE_SET pub_headers
        TYPE HEADERS
        BASE_DIRS
                include/XXXXXXXXXX-lib/)
target_sources(incplot-lib
    PRIVATE
        FILE_SET priv_headers
        TYPE HEADERS
        BASE_DIRS
                src/private_inc/)
                
target_compile_features(XXXXXXXXXX-lib PUBLIC cxx_std_23)

if(MINGW AND (CMAKE_BUILD_TYPE STREQUAL "Release"))
    target_link_options(XXXXXXXXXX-lib PUBLIC -static -static-libgcc -static-libstdc++)
endif()

if((CMAKE_SYSTEM_NAME STREQUAL "Darwin") AND (CMAKE_BUILD_TYPE STREQUAL "Release"))
  target_link_options(XXXXXXXXXX-lib PUBLIC -static-libgcc -static-libstdc++)
endif()



include(CMake_dependencies.cmake) ### Loads and declares the requires external libraries using both vcpkg and CMake's FetchContent.
target_link_libraries(incplot-lib PRIVATE )

target_link_libraries(incplot-lib PUBLIC )



option(XXXXXXXXXX_BUILD_DEMOS "Build demo executables" ${PROJECT_IS_TOP_LEVEL})
if(XXXXXXXXXX_BUILD_DEMOS)
    add_subdirectory(demos)
endif()

option(XXXXXXXXXX_BUILD_TESTS "Build test executables" ${PROJECT_IS_TOP_LEVEL})
if(XXXXXXXXXX_BUILD_TESTS)
    add_subdirectory(test)
endif()
