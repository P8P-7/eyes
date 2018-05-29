import QtQuick 2.0
import goliath.eyes 1.0
import QtGraphicalEffects 1.0

Item {
    id: eye

    property bool isRight: false

    width: parent.width / 2
    height: width * 0.75

    x: isRight ? width : 0
    y: parent.height / 2 - height / 2

    state: EmotionHandler.NEUTRAL

    states: [
        State {
            name: EmotionHandler.ANGRY
            PropertyChanges {
                target: topLid
            }
        },
        State {
            name: EmotionHandler.SAD
            PropertyChanges {
                target: topLid
            }
        },
        State {
            name: EmotionHandler.SUPRISED
            PropertyChanges {
                target: topLid
            }
        },
        State {
            name: EmotionHandler.HAPPY
            PropertyChanges {
                target: topLid
            }
        }
    ]

    transitions: [
        Transition {
            from: EmotionHandler.NEUTRAL
            to: EmotionHandler.ANGRY
            reversible: true
            // TODO: Implement angry animation
        },
        Transition {
            from: EmotionHandler.NEUTRAL
            to: EmotionHandler.SAD
            reversible: true
            // TODO: Implement sad animation
        },
        Transition {
            from: EmotionHandler.NEUTRAL
            to: EmotionHandler.SUPRISED
            reversible: true
            // TODO: Implement suprised animation
        },
        Transition {
            from: EmotionHandler.NEUTRAL
            to: EmotionHandler.HAPPY
            reversible: true
            // TODO: Implement happy animation
        }
    ]

    Rectangle {
        id: iris

        anchors.centerIn: parent

        width: parent.width * 0.8
        height: parent.height

        x: parent.width * 0.1

        color: "white"
        radius: width * 0.5

        Pupil {
            id: pupil
        }
    }

    Lid {
        id: topLid
    }

    Lid {
        id: bottomLid
        inverse: true
    }

    function blink() {
        // TODO: Implement blink animation
    }
}
