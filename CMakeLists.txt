cmake_minimum_required(VERSION 3.20)
project(MyProject) # <- change it!!

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# -------------------------------
# Auto-detect vcpkg toolchain
# -------------------------------
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    # Check if user set VCPKG_ROOT
    if(DEFINED ENV{VCPKG_ROOT})
        set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake"
            CACHE STRING "Vcpkg toolchain file")
    else()
        # Try $HOME/vcpkg (Linux/macOS)
        if(DEFINED ENV{HOME} AND EXISTS "$ENV{HOME}/vcpkg/scripts/buildsystems/vcpkg.cmake")
            set(CMAKE_TOOLCHAIN_FILE "$ENV{HOME}/vcpkg/scripts/buildsystems/vcpkg.cmake"
                CACHE STRING "Vcpkg toolchain file")
        endif()

        # Try %USERPROFILE%\vcpkg (Windows)
        if(WIN32 AND DEFINED ENV{USERPROFILE} AND EXISTS "$ENV{USERPROFILE}/vcpkg/scripts/buildsystems/vcpkg.cmake")
            set(CMAKE_TOOLCHAIN_FILE "$ENV{USERPROFILE}/vcpkg/scripts/buildsystems/vcpkg.cmake"
                CACHE STRING "Vcpkg toolchain file")
        endif()
    endif()
endif()

# -------------------------------
# Add executable
# -------------------------------
add_executable(${PROJECT_NAME} src/main.cpp)

# -------------------------------
# Dependencies
# -------------------------------

# glfw3 (always provides a config with vcpkg)
find_package(glfw3 CONFIG REQUIRED)

# glm (header-only, sometimes without config)
find_package(glm CONFIG QUIET)
if (NOT glm_FOUND)
    message(STATUS "GLM config not found, falling back to header-only include.")
    target_include_directories(${PROJECT_NAME} PRIVATE ${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include)
else()
    target_link_libraries(${PROJECT_NAME} PRIVATE glm::glm)
endif()

# glew
if(WIN32)
    # On Windows, vcpkg always provides a config for GLEW
    find_package(glew CONFIG REQUIRED)
    message(STATUS "Using GLEW via vcpkg config (Windows).")
    target_link_libraries(${PROJECT_NAME} PRIVATE GLEW::GLEW)
else()
    # On Linux/macOS, config may or may not exist
    find_package(glew CONFIG QUIET)
    if (glew_FOUND)
        message(STATUS "Using GLEW via vcpkg config (Linux/macOS).")
        target_link_libraries(${PROJECT_NAME} PRIVATE GLEW::GLEW)
    else()
        message(STATUS "Using GLEW via system/vcpkg fallback (Linux/macOS).")
        find_package(OpenGL REQUIRED)
        target_link_libraries(${PROJECT_NAME} PRIVATE GLEW OpenGL::GL)
    endif()
endif()

# Link glfw (all platforms)
target_link_libraries(${PROJECT_NAME} PRIVATE glfw)
