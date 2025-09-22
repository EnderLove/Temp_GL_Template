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

:: Detect compiler
:: First ensure VS environment is loaded (for cl.exe)
if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
    call "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
)

where cl >nul 2>nul
if not errorlevel 1 goto :MSVC

where g++ >nul 2>nul
if not errorlevel 1 goto :MINGW

echo ERROR: No compiler found. Please install Visual Studio Build Tools or MinGW.
goto :END

:MSVC
echo Found MSVC compiler (Visual Studio).
if defined CMAKE_GENERATOR (
    set "GENERATOR=%CMAKE_GENERATOR%"
) else (
    set "GENERATOR=Visual Studio 17 2022"
)
cmake .. -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake -G "%GENERATOR%" -A x64
cmake --build . --config Release
goto :END

:MINGW
echo Found MinGW compiler.
if "%1"=="static" (
    set "MINGW_TRIPLET=x64-mingw-static"
) else (
    set "MINGW_TRIPLET=x64-mingw-dynamic"
)
cmake .. -DCMAKE_TOOLCHAIN_FILE=%VCPKG_ROOT%\scripts\buildsystems\vcpkg.cmake ^
         -DVCPKG_TARGET_TRIPLET=%MINGW_TRIPLET% ^
         -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build .
goto :END

:END
echo.
echo ====== Setup complete! ======
pause
