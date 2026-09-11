set(CMAKE_SYSTEM_NAME Windows)

set(_LLVM_BIN "C:/Program Files/Microsoft Visual Studio/18/Community/VC/Tools/Llvm/x64/bin")

set(CMAKE_C_COMPILER   "${_LLVM_BIN}/clang-cl.exe" CACHE FILEPATH "" FORCE)
set(CMAKE_CXX_COMPILER "${_LLVM_BIN}/clang-cl.exe" CACHE FILEPATH "" FORCE)

set(CMAKE_LINKER_TYPE LLD CACHE STRING "" FORCE)
set(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=\"${_LLVM_BIN}/lld-link.exe\"" CACHE STRING "" FORCE)

unset(_LLVM_BIN)