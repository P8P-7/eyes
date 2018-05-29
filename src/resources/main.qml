import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Shapes 1.10
import goliath.eyes 1.0

Window {
    id: window

    visible: true
    title: "Goliath II's Eyes"
    color: "black"
    visibility: "FullScreen"

    EmotionHandler {
        objectName: "emotion"
        onEmotionChanged: {
            switch (emotion) {
                case EmotionHandler.WINK_LEFT:
                    leftEye.blink();
                    break;
                case EmotionHandler.WINK_RIGHT:
                    rightEye.blink();
                    break;
                default:
                    rightEye.state = emotion;
                    leftEye.state = emotion;
                    break;
            }
        }
    }

    Eye {
        id: rightEye
    }

    Eye {
        id: leftEye

        isRight: true
    }
}
