@echo off
setlocal

set VCPKG_ROOT=%~dp0vcpkg

if not exist "%VCPKG_ROOT%" (
    echo Cloning vcpkg...
    git clone https://github.com/microsoft/vcpkg.git "%VCPKG_ROOT%"
    call "%VCPKG_ROOT%\bootstrap-vcpkg.bat"
)

if not exist build mkdir build
cd build

cmake .. -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake -DCMAKE_BUILD_TYPE=Release

cmake --build . --config Release

echo.
echo ====== Setup complete! ======
pause