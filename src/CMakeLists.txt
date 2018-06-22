set(SOURCES
        main.cpp
        emotion_handler.cpp
        )

qt5_add_resources(RESOURCES resources/resources.qrc)

add_executable(${PROJECT_NAME}
        ${SOURCES}
        ${RESOURCES}
        )

target_link_libraries(${PROJECT_NAME}
        PUBLIC
            goliath-proto
            goliath-zmq-messaging-module
            Qt5::Core
            Qt5::Quick
            Qt5::Qml
        )
