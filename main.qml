import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Shapes 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
//    visibility: "FullScreen"
    color: "#000000"

    MouseArea {
        id: row
        x: 0
        y: 0
        width: parent.width
        height: parent.height

        function blink() {
            eyeLeft.blink()
            eyeRight.blink()
        }

        function setState(emotion){
            eyeLeft.setState(emotion)
            eyeRight.setState(emotion)
        }

        onClicked: row.setState("angry")

        Timer {
            interval: 3000; running: true; repeat: true
            onTriggered: row.blink()
        }

        Eye{
            id: eyeLeft
            width: parent.width/2
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            transformOrigin: Item.Center
            flipped: 1
            state: "neutral"
            clip: true
        }

        Eye{
            id: eyeRight
            width: parent.width/2
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            transformOrigin: Item.Center
            flipped: -1
            state: "neutral"
            clip: true
        }
    }

}
