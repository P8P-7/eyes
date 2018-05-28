set(SOURCES
        main.cpp
        emotion_handler.cpp
        )

add_executable(${PROJECT_NAME}
        resources/resources.qrc
        ${SOURCES}
        )

target_link_libraries(${PROJECT_NAME}
        PUBLIC
            goliath-proto
            goliath-zmq-messaging-module
            Qt5::Core
            Qt5::Quick
            Qt5::Qml
        )