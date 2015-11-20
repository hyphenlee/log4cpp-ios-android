rm -rf build
mkdir build
cd build
#set -DIOS_PLATFORM=OS for real device
cmake .. -DCMAKE_TOOLCHAIN_FILE=../IOS.cmake -DIOS_PLATFORM=SIMULATOR64 -GXcode
