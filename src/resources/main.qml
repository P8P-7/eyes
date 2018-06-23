import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Shapes 1.0
import goliath.eyes 1.0

Window {
    id: window
    visible: true
    width: 480
    height: 320
    title: qsTr("Goliath II")
//    visibility: "FullScreen"
    color: "#000000"

    property int pupilSize: 0

    EmotionHandler {
        objectName: "emotion"
        onEmotionChanged: {
            switch (emotion) {
                case EmotionHandler.WINK_LEFT:
                    eyeLeft.blink();
                    break;
                case EmotionHandler.WINK_RIGHT:
                    eyeRight.blink();
                    break;
                default:
                    eyeRight.setState(emotion);
                    eyeLeft.setState(emotion);
                    break;
            }
        }
    }

    Rectangle {
        id: row
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "#000000"


        function blink() {
            eyeLeft.blink()
            eyeRight.blink()
        }

        function setState(emotion){
            eyeLeft.setState(emotion)
            eyeRight.setState(emotion)
        }

        function moveEyes(){
            var randomX = Math.random() * (eyeLeft.width / 4) * (Math.random() < 0.5 ? -1 : 1)
            var randomY = Math.random() * (eyeLeft.width / 15) * (Math.random() < 0.5 ? -1 : 1)
            eyeLeft.moveEye(randomX,randomY)
            eyeRight.moveEye(randomX,randomY)
        }

        Timer {
            id: blink_timer
            interval: 3000; running: true; repeat: true
            onTriggered: row.blink()
        }

        Timer {
            id: eyeMovementTimer
            interval: 4680; running: true; repeat: true
            onTriggered: row.moveEyes()
        }

        Startup{
            width: parent.width
            height: parent.height
        }

        Eye {
            id: eyeLeft
            width: parent.width / 2
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            flipped: 1
            clip: true
        }

        Eye {
            id: eyeRight
            width: parent.width/2
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            flipped: -1
            clip: true
        }
    }
}
