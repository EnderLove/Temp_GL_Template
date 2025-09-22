# OpenGLProject

This project is an OpenGL-based application built with **C++17**, using **GLFW**, **GLEW**, and **GLM** via [vcpkg](https://github.com/microsoft/vcpkg) as the package manager.

---

## Prerequisites

Before building the project, ensure the following:

1. **C++ Compiler**:  
   - **Preferred:** MSVC (via Visual Studio Community or Build Tools)  
   - **Alternative:** MinGW (if MSVC is not installed)  

2. **CMake** installed on your system.

3. **vcpkg** downloaded and bootstrapped:  
   - Either in the project folder (`./vcpkg`)  
   - Or in a system path like `C:\vcpkg`

---

## Initial Setup

1. **Verify vcpkg**:  

   Run the `setup.bat` file included in the project root. This batch file will:

   - Check if vcpkg exists in the project folder or in `C:\vcpkg`.
   - If missing, ask if you want to clone vcpkg into `C:\vcpkg`.
   - Bootstrap vcpkg if required.

   **Usage:**

   ```cmd
   call setup.bat

## Building the project
    After verifying vcpkg, build the project with CMake. Replace <path_to_vcpkg> with the actual path where your vcpkg is located.
    ```powershell
    cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=<path_to_vcpkg>\scripts\buildsystems\vcpkg.cmake -DCMAKE_BUILD_TYPE=Release
    cmake --build build --config Release

    ```