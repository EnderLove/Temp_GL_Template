# My OpenGL Project

This project uses **CMake** and **vcpkg** as its package manager.

You can build it in two ways:
1. Use your **existing global vcpkg installation**.
2. Use the **provided setup scripts** to install a **local vcpkg copy** inside this repo.

---

## 🔧 Requirements
- Git
- CMake (>= 3.21 recommended)
- A C++17 compiler
- (Optional) vcpkg, if you already have it installed globally.

---

## 🚀 Option 1: Use existing vcpkg (global)
If you already have vcpkg installed on your system:

### Windows
```powershell
cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```

### Linux
```bash
cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```
