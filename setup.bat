@echo off
setlocal

:: Set default vcpkg root relative to this script
set "VCPKG_ROOT=%~dp0vcpkg"

:: Check if vcpkg exists in project folder or in C:\
if not exist "%VCPKG_ROOT%" (
    if exist "C:\vcpkg" (
        set "VCPKG_ROOT=C:\vcpkg"
        echo Found vcpkg in C:\vcpkg
    ) else (
        echo Cloning vcpkg into project folder...
        git clone https://github.com/microsoft/vcpkg.git "%VCPKG_ROOT%"
    )
)

:: Bootstrap vcpkg if needed
if not exist "%VCPKG_ROOT%\vcpkg.exe" (
    echo Bootstrapping vcpkg...
    call "%VCPKG_ROOT%\bootstrap-vcpkg.bat"
) else (
    echo vcpkg already bootstrapped.
)

:: Create build folder if missing
if not exist build mkdir build
cd build

:: Detect compiler
where cl >nul 2>nul
if %ERRORLEVEL%==0 goto :MSVC

where g++ >nul 2>nul
if %ERRORLEVEL%==0 goto :MINGW

echo ERROR: No compiler found. Please install Visual Studio Build Tools or MinGW.
goto :END

:MSVC
echo Found MSVC compiler (Visual Studio).
cmake .. -DCMAKE_TOOLCHAIN_FILE="%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake" -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release
goto :END

:MINGW
echo Found MinGW compiler.
cmake .. -DCMAKE_TOOLCHAIN_FILE="%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake" ^
         -DVCPKG_TARGET_TRIPLET=x64-mingw-dynamic ^
         -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build .
goto :END

:END
echo.
echo ====== Setup complete! ======
pause
