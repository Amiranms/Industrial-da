project(C)


add_executable(C main.cpp)

target_link_libraries(C ClassLib)

target_include_directories(C PRIVATE ${CMAKE_SOURCE_DIR}/B)

