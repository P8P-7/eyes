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
                case EmotionHandler.ANGRY:
                    console.log("Angry");
                    break;
                case EmotionHandler.SAD:
                    console.log("Sad :(");
                    break;
                case EmotionHandler.SUPRISED:
                    console.log("Suprised");
                    break;
                case EmotionHandler.HAPPY:
                    console.log("Happy");
                    break;
                case EmotionHandler.WINK_LEFT:
                    console.log("Wink Left");
                    break;
                case EmotionHandler.WINK_RIGHT:
                    console.log("Wink Right");
                    break;
                case EmotionHandler.NEUTRAL:
                default:
                    console.log("Neutral");
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
