@echo off
setlocal

set "VCPKG_ROOT=%~dp0vcpkg"

if not exist "%VCPKG_ROOT%" (
    if exist "C:\vcpkg" (
        set "VCPKG_ROOT=C:\vcpkg"
        echo Found vcpkg in C:\vcpkg
    ) else (
        echo Cloning vcpkg into project folder...
        git clone https://github.com/microsoft/vcpkg.git "%VCPKG_ROOT%"
        call "%VCPKG_ROOT%\bootstrap-vcpkg.bat"
    )
) else (
    echo vcpkg already exists in project folder
)

if not exist build mkdir build

echo.
echo ================= VCPKG is ready!!! ===========
echo Open this folder in VS Code and let CMake tools configure/build.
pause