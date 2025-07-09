project(B)

add_library(ClassLib SHARED lib.cpp)

target_include_directories(ClassLib PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
