import QtQuick 2.9
import QtQuick.Shapes 1.0
import goliath.eyes 1.0

Item {
    id: eye
    visible: false
    property int flipped: 1
    property int topArcAngle: 0
    property int bottomArcAngle: 0
    property int topArcY: 0
    property int bottomArcY: 0
    property int pupilX: 0
    property int pupilY: 0
    property int speed: 30

    onActiveFocusChanged: window.pupilSize = pupil.width

     Timer {
         id: startup
         interval: 5000; running: false; repeat: false
         onTriggered: visible = true
     }

    function blink(){
        blinkTop.start()
        blinkBottom.start()
        startup.start()
    }

    function setState(emotion){
        state = emotion
        eye.blink()
    }

    function moveEye(x,y){
        pupilX = x
        pupilY = y
        moveEyeAnimation.start()
    }

    ParallelAnimation{
        running: false
        id: moveEyeAnimation
        loops: 1
        PropertyAnimation { target: pupil; property: "anchors.horizontalCenterOffset"; easing.type: Easing.InOutCubic; to: pupilX; duration: 500 }
        PropertyAnimation { target: pupil; property: "anchors.verticalCenterOffset"; easing.type: Easing.InOutCubic; to: pupilY; duration: 500 }
    }

    SequentialAnimation{
        running: false
        id: blinkTop
        loops: 1
        ParallelAnimation{
            PropertyAnimation { target: top_lid; property: "y"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
            PropertyAnimation { target: top_arc; property: "xAxisRotation"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
            PropertyAnimation { target: top_arc; property: "radiusY"; easing.type: Easing.InOutCubic; to: 1; duration: 100 / (speed / 100) }
        }
        PauseAnimation {
            duration: 500
        }
        ParallelAnimation{
            PropertyAnimation { target: top_lid; property: "y"; easing.type: Easing.InOutCubic; to: topArcY; duration: 150 / (speed / 100) }
            PropertyAnimation { target: top_arc; property: "xAxisRotation"; easing.type: Easing.InOutCubic; to: topArcAngle; duration: 150 / (speed / 100) }
            PropertyAnimation { target: top_arc; property: "radiusY"; easing.type: Easing.InOutCubic; to: window.height/8; duration: 150 / (speed / 100) }
        }
    }

    SequentialAnimation{
        running: false
        id: blinkBottom
        loops: 1
        ParallelAnimation{
            PropertyAnimation { target: bottom_lid; property: "y"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
            PropertyAnimation { target: bottom_arc; property: "xAxisRotation"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
            PropertyAnimation { target: bottom_arc; property: "radiusY"; easing.type: Easing.InOutCubic; to: 1; duration: 100 / (speed / 100) }
        }
        PauseAnimation {
            duration: 500
        }
        ParallelAnimation{
            PropertyAnimation { target: bottom_lid; property: "y"; easing.type: Easing.InOutCubic; to: bottomArcY; duration: 150 / (speed / 100) }
            PropertyAnimation { target: bottom_arc; property: "xAxisRotation"; easing.type: Easing.InOutCubic; to: bottomArcAngle; duration: 150 / (speed / 100) }
            PropertyAnimation { target: bottom_arc; property: "radiusY"; easing.type: Easing.InOutCubic; to: window.height/15; duration: 150 / (speed / 100) }
        }
    }

    states: [
        State {
            name: EmotionHandler.NEUTRAL
            PropertyChanges { target: top_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; topArcAngle: 10 * eye.flipped }
            PropertyChanges { target: eye; bottomArcAngle: -5 * eye.flipped }
            PropertyChanges { target: eye; topArcY: -iris.height/3}
            PropertyChanges { target: eye; bottomArcY: iris.height/3}
            PropertyChanges { target: blink_timer; interval: 5000}
        },
        State {
            name: EmotionHandler.ANGRY
            PropertyChanges { target: top_arc; xAxisRotation: 20 * eye.flipped }
            PropertyChanges { target: bottom_arc; xAxisRotation: 5 * eye.flipped }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; topArcAngle: 20 * eye.flipped }
            PropertyChanges { target: eye; bottomArcAngle: 5 * eye.flipped }
            PropertyChanges { target: eye; topArcY: -iris.height/10}
            PropertyChanges { target: eye; bottomArcY: iris.height/10}
            PropertyChanges { target: blink_timer; interval: 5000}
        },
        State {
            name: EmotionHandler.HAPPY
            PropertyChanges { target: top_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; xAxisRotation: -3 * eye.flipped }
            PropertyChanges { target: bottom_arc; direction: PathArc.Clockwise}
            PropertyChanges { target: eye; topArcAngle: 0 }
            PropertyChanges { target: eye; bottomArcAngle: -8 * eye.flipped }
            PropertyChanges { target: eye; topArcY: -iris.height/2}
            PropertyChanges { target: eye; bottomArcY: iris.height/3}
            PropertyChanges { target: blink_timer; interval: 2500}
        },
        State {
            name: EmotionHandler.SAD
            PropertyChanges { target: top_arc; xAxisRotation: -20 * eye.flipped }
            PropertyChanges { target: bottom_arc; xAxisRotation: -1 * eye.flipped }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; topArcAngle: -20 * eye.flipped }
            PropertyChanges { target: eye; bottomArcAngle: -10 * eye.flipped }
            PropertyChanges { target: eye; topArcY: -iris.height/10}
            PropertyChanges { target: eye; bottomArcY: iris.height/10}
            PropertyChanges { target: blink_timer; interval: 2500}
        },
        State {
            name: EmotionHandler.SUPRISED
            PropertyChanges { target: top_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; topArcAngle: 0 }
            PropertyChanges { target: eye; bottomArcAngle: 0 }
            PropertyChanges { target: eye; topArcY: -iris.height/2}
            PropertyChanges { target: eye; bottomArcY: iris.height/2}
            PropertyChanges { target: blink_timer; interval: 8000}
        }
    ]

    Rectangle {
        id: iris
        width: parent.width < parent.height ? parent.width * 0.8 : parent.height * 0.8
        height: width
        color: "#eeeeff"
        radius: width*0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        clip: true

        Rectangle {
            id: pupil
            width: parent.width< parent.height ? parent.width * 0.3 : parent.height * 0.3
            height: width
            color: "#000000"
            radius: width * 0.5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                id: speckle
                width: parent.width / 4
                height: width
                color: "#eeeeff"
                radius: width * 0.5
                anchors.right: parent.right
                anchors.rightMargin: width / 1.5
                anchors.top: parent.top
                anchors.topMargin: height / 1.5
            }

        }
    }

    Rectangle {
        id: top_lid
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0

        Shape {
            id: top_lid_shape
            anchors.fill: parent

            ShapePath {
                id: path
                fillColor: "black"
                strokeColor: "black"
                startX: -iris.width/2
                startY: 0
                PathLine{
                    x: -iris.width/2
                    y: eye.height/2
                }
                PathArc {
                    id: top_arc
                    x: iris.width/2
                    y: eye.height/2
                    radiusX: 200; radiusY: window.height/15
                    useLargeArc: false
                    direction: PathArc.Clockwise
                    xAxisRotation: 0
                }
                PathLine{
                    x: iris.width/2
                    y: 0
                }
            }
        }
    }

    Rectangle {
        id: bottom_lid
        anchors.horizontalCenter: parent.horizontalCenter
        y: -eye.height

        Shape {
            id: bottom_lid_shape
            anchors.fill: parent

            ShapePath {
                id: p2
                fillColor: "black"
                strokeColor: "black"
                startX: -iris.width/2
                startY: eye.height
                PathLine{
                    x: -iris.width/2
                    y: eye.height/2
                }
                PathArc {
                    id: bottom_arc
                    x: iris.width/2
                    y: eye.height/2
                    radiusX: 200; radiusY: window.height/15

                    useLargeArc: false
                    direction: PathArc.Counterclockwise
                    xAxisRotation: 0
                }
                PathLine{
                    x: iris.width/2
                    y: eye.height
                }
            }
        }
    }
}
