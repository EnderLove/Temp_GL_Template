set -e

VCPKG_ROOT="$(dirname "$0")/vcpkg"

if [ ! -d "$VCPKG_ROOT" ]; then
    echo "Cloning vcpkg..."
    git clone https://github.com/microsoft/vcpkg.git "$VCPKG_ROOT"
    bash "$VCPKG_ROOT/bootstrap-vcpkg.sh"
fi

mkdir -p build
cd build

cmake .. \
    -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake" \
    -DCMAKE_BUILD_TYPE=Release

cmake --build . --config Release

echo 
echo "========= Setup complete! ========="