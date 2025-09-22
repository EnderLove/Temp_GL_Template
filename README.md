# OpenGLProject_Template

Hi everyone! I'm Ender, and this is my first OpenGL template.
I hope this project grows over time with the feedback of those willing to try this magnificent template. :D

This project is an OpenGL-based application built with **C++17**, using **GLFW**, **GLEW**, and **GLM** via [vcpkg](https://github.com/microsoft/vcpkg) as the package manager.

---

## Prerequisites

Before building the project, ensure the following:

1. **C++ Compiler**:

   * **Preferred:** MSVC (via Visual Studio Community or Build Tools)
   * **Alternative:** MinGW (if MSVC is not installed)

2. **CMake** installed on your system.

3. **vcpkg** downloaded and bootstrapped:

   * Either in the project folder (`./vcpkg`)
   * Or in a system path like `C:\vcpkg`

---

## Initial Setup

1. **Verify vcpkg**:

   Run the `setup.bat` file included in the project root. This batch file will:

   * Check if vcpkg exists in the project folder or in `C:\vcpkg`.
   * If missing, ask if you want to clone vcpkg into `C:\vcpkg`.
   * Bootstrap vcpkg if required.

   **Usage:**

   ```cmd
   call setup.bat
   ```
---

## Building the Project

REMEMBER: Since this is a template, change the project name to personalize your project
```powershell
cmake_minimum_required(VERSION X.XX)
project(MyOpenGLProject) <- rename this
```

After verifying vcpkg, build the project with CMake. Replace `<path_to_vcpkg>` with the actual path where your vcpkg is located.

```powershell
cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=<path_to_vcpkg>\scripts\buildsystems\vcpkg.cmake -DCMAKE_BUILD_TYPE=Release
```

Now you can build it.

```powershell
cmake --build build --config Release
```

* This will generate a **`.sln` file** if using MSVC, or Makefiles if using MinGW.
* The project will be built in the `build` folder.

---

## Using the Project in VS Code

1. Open the project folder in **VS Code**.
2. Install the **CMake Tools** extension.
3. The extension will detect the `.sln` file or Makefiles automatically.
4. Use the **Build**, **Run**, and **Debug** buttons from VS Code.

---

## Notes

* Make sure the **vcpkg path** used in the CMake command matches where `vcpkg.exe` is located.
* If MSVC is not installed, MinGW will be used instead (Makefiles will be generated).
* All third-party dependencies (`glfw3`, `GLEW`, `glm`) are managed via vcpkg.

---

