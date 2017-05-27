# project
cmake_minimum_required(VERSION 2.4)
project(sgm)

# build release version
set(CMAKE_BUILD_TYPE Release)
set(CMAKE_CXX_FLAGS_RELEASE "-Wall -O3 -msse3")
#set(CMAKE_CXX_FLAGS_RELEASE "-Wall -O3 -msse4.2 -DMM_POPCNT")

# build debug version
#set(CMAKE_BUILD_TYPE Debug)
#set(CMAKE_CXX_FLAGS_DEBUG "-Wall -msse3")
#set(CMAKE_CXX_FLAGS_DEBUG "-Wall -msse4.2 -DMM_POPCNT")

# libraries
find_library(DAISY daisy daisy-1.8.1/lib/)
find_library(PNG png)

# openmp
find_package(OpenMP)
if (OPENMP_FOUND)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fopenmp")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")
endif()

# sources & output
file(GLOB SRC_FILES "src/*.cpp")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ../)

# build
add_executable(sgmstereo ${SRC_FILES})
include_directories(${CMAKE_SOURCE_DIR}/include)
target_link_libraries(sgmstereo ${PNG} ${DAISY})

# build
add_executable(sgmerror ${SRC_FILES})
include_directories(${CMAKE_SOURCE_DIR}/include)
target_link_libraries(sgmerror ${PNG} ${DAISY})
target_compile_definitions(sgmerror PUBLIC "-DBUILD_SGMERROR")

