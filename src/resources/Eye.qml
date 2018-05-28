import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: eye

    property bool isRight: false

    width: parent.width / 2
    height: width * 0.75

    x: isRight ? width : 0
    y: parent.height / 2 - height / 2

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

    function neutral() {
        // TODO: Implement neutral animation
    }

    function blink() {
        // TODO: Implement blink animation
    }

    function angry(browDirection) {
        // TODO: Implement angry animation
    }

    function sad(browDirection) {
        // TODO: Implement sad animation
    }

    function suprised() {
        // TODO: Implement suprised animation
    }

    function happy() {
        // TODO: Implement happy animation
    }
}
