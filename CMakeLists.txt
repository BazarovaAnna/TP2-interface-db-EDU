cmake_minimum_required(VERSION 3.24)
project(TP2-interface-db)

set(CMAKE_CXX_STANDARD 17)
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -static-libstdc++ -static-libgcc")

link_directories(${CMAKE_SOURCE_DIR}/bin)

add_executable(TP2-interface-db src/main.cpp headers/IGeoConnectDB.h headers/IGeoProjects.h headers/IGeoProject.h headers/IGeoListInterface.h headers/IGeoInterface.h headers/IGeoTables.h)

target_link_libraries(TP2-interface-db geodata_x86_64.dll)