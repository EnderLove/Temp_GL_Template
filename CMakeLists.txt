cmake_minimum_required(VERSION 3.20)
project(OpenGLProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Use vcpkg toolchain if VCPKG_ROOT is set
if(DEFINED ENV{VCPKG_ROOT})
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")
endif()

# Add executable
add_executable(${PROJECT_NAME} src/main.cpp)

# Find packages installed by vcpkg
find_package(glfw3 CONFIG REQUIRED)
find_package(GLEW CONFIG REQUIRED)
find_package(glm CONFIG REQUIRED)

# Link libraries
target_link_libraries(${PROJECT_NAME} PRIVATE glfw GLEW::GLEW glm::glm)
