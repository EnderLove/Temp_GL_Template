#!/bin/bash

# Set default VCPKG root relative to this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VCPKG_ROOT="$SCRIPT_DIR/vcpkg"

# Check if vcpkg exists in project folder
if [ -f "$VCPKG_ROOT/vcpkg" ]; then
    echo "Found vcpkg in project folder."
else
    # Check if vcpkg exists in $HOME/vcpkg
    if [ -f "$HOME/vcpkg/vcpkg" ]; then
        VCPKG_ROOT="$HOME/vcpkg"
        echo "Found vcpkg in $HOME/vcpkg"
    else
        # Ask user if they want to clone
        read -p "vcpkg not found. Do you want to clone vcpkg in $HOME/vcpkg? [Y/N]: " USERCHOICE
        if [[ "$USERCHOICE" =~ ^[Yy]$ ]]; then
            echo "Cloning vcpkg into $HOME/vcpkg..."
            git clone https://github.com/microsoft/vcpkg.git "$HOME/vcpkg"
            VCPKG_ROOT="$HOME/vcpkg"
            echo "Bootstrapping vcpkg..."
            "$VCPKG_ROOT/bootstrap-vcpkg.sh"
        else
            echo "vcpkg setup canceled. Exiting."
            exit 1
        fi
    fi
fi

echo
echo "vcpkg is ready at $VCPKG_ROOT"

# ------------------------------
# Run CMake configuration & build
# ------------------------------

BUILD_DIR="$SCRIPT_DIR/build"

echo
echo "Configuring project with CMake..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake .. -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake" -DCMAKE_BUILD_TYPE=Release

echo
echo "Building project..."
cmake --build . -j$(nproc)

echo
echo "✅ Build finished!"
echo "You can run your program from: $BUILD_DIR"
