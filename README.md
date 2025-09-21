# OpenGL Project Template

This is a cross-platform OpenGL project template using CMake and vcpkg.

## How to build

### Linux
```bash
vcpkg install --triplet x64-linux
mkdir build && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=~/Projects/vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build .
./OpenGLProject

### Windows 
vcpkg install --triplet x64-windows
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=C:/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake
cmake --build .
.\Debug\OpenGLProject.exe
