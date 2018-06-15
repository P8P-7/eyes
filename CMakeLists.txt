cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

project(goliath-eyes LANGUAGES CXX)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD 14)

set(QT_MIN_VERSION "5.10.0")

find_package(Qt5 ${QT_MIN_VERSION}
        COMPONENTS
            Core
            Quick
            Qml
        REQUIRED
        )

find_package(Qt5QuickCompiler REQUIRED)

add_subdirectory(third_party)
add_subdirectory(src)