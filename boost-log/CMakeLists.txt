
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../bin)

find_package(Boost
  REQUIRED
  COMPONENTS
    thread
    system
    date_time
    log_setup
    log
)
find_package(Threads REQUIRED)

include_directories(${Boost_INCLUDE_DIR})

add_executable(logger logger.cpp)

target_link_libraries(logger LINK_PUBLIC ${CMAKE_THREAD_LIBS_INIT} ${Boost_LIBRARIES})
