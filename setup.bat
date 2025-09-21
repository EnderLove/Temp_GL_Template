@echo off
setlocal

set VCPKG_ROOT=%~dp0vcpkg

:: Clone vcpkg if missing
if not exist "%VCPKG_ROOT%" (
    echo Cloning vcpkg...
    git clone https://github.com/microsoft/vcpkg.git "%VCPKG_ROOT%"
    call "%VCPKG_ROOT%\bootstrap-vcpkg.bat"
)

if not exist build mkdir build
cd build

:: Try MSVC first
where cl >nul 2>nul
if %ERRORLEVEL%==0 (
    echo Found MSVC compiler (Visual Studio).
    cmake .. -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake -G "Visual Studio 17 2022" -A x64
    cmake --build . --config Release
) else (
    echo No MSVC found, falling back to MinGW/Makefiles...
    cmake .. -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release
    cmake --build .
)

echo.
echo ====== Setup complete! ======
pause
