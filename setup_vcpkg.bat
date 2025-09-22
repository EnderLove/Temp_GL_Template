@echo off
setlocal

:: Set default vcpkg root relative to this script
set "VCPKG_ROOT=%~dp0vcpkg"

:: Check if vcpkg exists in project folder
if exist "%VCPKG_ROOT%\vcpkg.exe" (
    echo Found vcpkg in project folder.
    goto :READY
)

:: Check if vcpkg exists in C:\
if exist "C:\vcpkg\vcpkg.exe" (
    set "VCPKG_ROOT=C:\vcpkg"
    echo Found vcpkg in C:\vcpkg
    goto :READY
)

:: Ask user if they want to clone it in C:\
echo vcpkg not found in project folder or in C:\vcpkg
set /p USERCHOICE=Do you want to clone vcpkg in C:\vcpkg? [Y/N]: 

if /I "%USERCHOICE%"=="Y" (
    echo Cloning vcpkg into C:\vcpkg...
    git clone https://github.com/microsoft/vcpkg.git "C:\vcpkg"
    set "VCPKG_ROOT=C:\vcpkg"
    echo Bootstrapping vcpkg...
    call "%VCPKG_ROOT%\bootstrap-vcpkg.bat"
    goto :READY
) else (
    echo vcpkg setup canceled. Exiting.
    goto :END
)

:READY
echo.
echo vcpkg is ready at "%VCPKG_ROOT%"
pause

:END
endlocal
