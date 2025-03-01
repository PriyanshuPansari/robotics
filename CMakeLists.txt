cmake_minimum_required(VERSION 3.20)
project(RoboSim VERSION 0.1.0 LANGUAGES CXX)

# Require C++23
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Build type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug")
endif()

# Output directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Find dependencies
find_package(OpenGL REQUIRED)
find_package(glfw3 REQUIRED)
find_package(GLEW REQUIRED)
find_package(Eigen3 REQUIRED)

# Add include directories
include_directories(
  ${PROJECT_SOURCE_DIR}/src
  ${PROJECT_SOURCE_DIR}/include
  ${EIGEN3_INCLUDE_DIR}
)

# Collect all source files
file(GLOB_RECURSE SOURCES 
  ${PROJECT_SOURCE_DIR}/src/*.cpp
)

# Create main executable
add_executable(robosim ${SOURCES})

# Link libraries
target_link_libraries(robosim 
  PRIVATE
    OpenGL::GL
    glfw
    GLEW::GLEW
)

# Enable warnings
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
  target_compile_options(robosim PRIVATE -Wall -Wextra -Wpedantic)
elseif(MSVC)
  target_compile_options(robosim PRIVATE /W4)
endif()

# Install
install(TARGETS robosim DESTINATION bin)

# Testing
option(BUILD_TESTING "Build the testing tree" ON)
if(BUILD_TESTING)
  enable_testing()
  add_subdirectory(tests)
endif()
