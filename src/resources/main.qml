import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Shapes 1.0
import goliath.eyes 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
//  visibility: "FullScreen"
    color: "#000000"

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

        onClicked: row.blink()

        Timer {
            interval: 3000; running: true; repeat: true
            onTriggered: row.blink()
        }

        Eye {
            id: eyeLeft
            width: parent.width / 2
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            transformOrigin: Item.Center
            flipped: 1
            state: EmotionHandler.NEUTRAL
            clip: true
        }

        Eye {
            id: eyeRight
            width: parent.width/2
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            transformOrigin: Item.Center
            flipped: -1
            state: EmotionHandler.NEUTRAL
            clip: true
        }
    }

}
