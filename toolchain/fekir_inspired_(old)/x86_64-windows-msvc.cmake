execute_process(COMMAND
    vswhere.exe -latest -property installationPath
    OUTPUT_VARIABLE MSVC_INSTALLATION_PATH
    RESULT_VARIABLE RET
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
if(NOT RET EQUAL 0 )
  message( FATAL_ERROR "Failed to execute vswhere, error code ${RET}")
endif()
if(NOT MSVC_INSTALLATION_PATH)
  message( FATAL_ERROR "output of 'vswhere -latest -property installationPath' is empty")
endif()
cmake_path(NORMAL_PATH MSVC_INSTALLATION_PATH)


file(READ ${MSVC_INSTALLATION_PATH}/VC/Auxiliary/Build/Microsoft.VCToolsVersion.default.txt VCTOOLSVERSION)
string(STRIP ${VCTOOLSVERSION} VCTOOLSVERSION)
if(NOT VCTOOLSVERSION)
  message( FATAL_ERROR "Microsoft.VCRedistVersion.default.txt is empty")
endif()

set(MSVC_BIN_PATH     "${MSVC_INSTALLATION_PATH}/VC/Tools/MSVC/${VCTOOLSVERSION}/bin/Hostx64/x64")
set(MSVC_LIB_PATH     "${MSVC_INSTALLATION_PATH}/VC/Tools/MSVC/${VCTOOLSVERSION}/lib/x64")
set(MSVC_INCLUDE_PATH "${MSVC_INSTALLATION_PATH}/VC/Tools/MSVC/${VCTOOLSVERSION}/include")

set(CMAKE_C_COMPILER   ${MSVC_BIN_PATH}/cl.exe)
set(CMAKE_CXX_COMPILER ${MSVC_BIN_PATH}/cl.exe)
set(CMAKE_LINKER       ${MSVC_BIN_PATH}/link.exe)
set(CMAKE_AR           ${MSVC_BIN_PATH}/lib.exe)

link_directories("${MSVC_LIB_PATH}")
include_directories(SYSTEM "${MSVC_INCLUDE_PATH}")