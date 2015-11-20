rm -rf build
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../android.toolchain.cmake\
      -DANDROID_NDK=~/.ndk\
      -DCMAKE_BUILD_TYPE=Release \
      -DANDROID_ABI="armeabi"\
      -DANDROID_NATIVE_API_LEVEL=android-17 \
      ..
cmake --build .
