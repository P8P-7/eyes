import QtQuick 2.9
import QtQuick.Shapes 1.5
import goliath.eyes 1.0

Item {
    id: eye
    property int flipped: 1
    property int top_arc_angle: 0
    property int bottom_arc_angle: 0
    property int top_arc_y: -iris.height / 4
    property int bottom_arc_y: iris.height / 4
    property int speed: 10

    function blink(){
        blink_top.start()
        blink_bottom.start()
    }

    function setState(emotion){
        state = emotion
        eye.blink()
    }

    SequentialAnimation{
        running: false
        id: blink_top
        loops: 1
        ParallelAnimation{
            PropertyAnimation { target: top_lid; property: "y"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
            PropertyAnimation { target: top_arc; property: "xAxisRotation"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
            PropertyAnimation { target: top_arc; property: "radiusY"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
        }
        ParallelAnimation{
            PropertyAnimation { target: top_lid; property: "y"; easing.type: Easing.InOutCubic; to: top_arc_y; duration: 150 / (speed / 100) }
            PropertyAnimation { target: top_arc; property: "xAxisRotation"; easing.type: Easing.InOutCubic; to: top_arc_angle; duration: 150 / (speed / 100) }
            PropertyAnimation { target: top_arc; property: "radiusY"; easing.type: Easing.InOutCubic; to: iris.height / 20; duration: 100 / (speed / 100) }
        }
    }

    SequentialAnimation{
        running: false
        id: blink_bottom
        loops: 1
        ParallelAnimation{
            PropertyAnimation { target: bottom_lid; property: "y"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
            PropertyAnimation { target: bottom_arc; property: "xAxisRotation"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
            PropertyAnimation { target: bottom_arc; property: "radiusY"; easing.type: Easing.InOutCubic; to: 0; duration: 100 / (speed / 100) }
        }
        ParallelAnimation{
            PropertyAnimation { target: bottom_lid; property: "y"; easing.type: Easing.InOutCubic; to: bottom_arc_y; duration: 150 / (speed / 100) }
            PropertyAnimation { target: bottom_arc; property: "xAxisRotation"; easing.type: Easing.InOutCubic; to: bottom_arc_angle; duration: 150 / (speed / 100) }
            PropertyAnimation { target: bottom_arc; property: "radiusY"; easing.type: Easing.InOutCubic; to: iris.height / 20; duration: 100 / (speed / 100) }
        }
    }

    states: [
        State {
            name: EmotionHandler.NEUTRAL
            PropertyChanges { target: top_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; top_arc_angle: 0 }
            PropertyChanges { target: eye; bottom_arc_angle: 0 }
            PropertyChanges { target: eye; top_arc_y: -iris.height / 4}
            PropertyChanges { target: eye; bottom_arc_y: iris.height / 4}
        },
        State {
            name: EmotionHandler.ANGRY
            PropertyChanges { target: top_arc; xAxisRotation: 20 * eye.flipped }
            PropertyChanges { target: bottom_arc; xAxisRotation: 5 * eye.flipped }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; top_arc_angle: 20 * eye.flipped }
            PropertyChanges { target: eye; bottom_arc_angle: 5 * eye.flipped }
            PropertyChanges { target: eye; top_arc_y: -iris.height / 10}
            PropertyChanges { target: eye; bottom_arc_y: iris.height / 10}
        },
        State {
            name: EmotionHandler.HAPPY
            PropertyChanges { target: top_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; top_arc_angle: 0 }
            PropertyChanges { target: eye; bottom_arc_angle: 0 }
            PropertyChanges { target: eye; top_arc_y: -iris.height / 4}
            PropertyChanges { target: eye; bottom_arc_y: iris.height / 4}
        },
        State {
            name: EmotionHandler.SAD
            PropertyChanges { target: top_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; top_arc_angle: 0 }
            PropertyChanges { target: eye; bottom_arc_angle: 0 }
            PropertyChanges { target: eye; top_arc_y: -iris.height / 4}
            PropertyChanges { target: eye; bottom_arc_y: iris.height / 4}
        },
        State {
            name: EmotionHandler.SUPRISED
            PropertyChanges { target: top_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; xAxisRotation: 0 }
            PropertyChanges { target: bottom_arc; direction: PathArc.Counterclockwise}
            PropertyChanges { target: eye; top_arc_angle: 0 }
            PropertyChanges { target: eye; bottom_arc_angle: 0 }
            PropertyChanges { target: eye; top_arc_y: -iris.height / 4}
            PropertyChanges { target: eye; bottom_arc_y: iris.height / 4}
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
            width: parent.width< parent.height ? parent.width * 0.2 : parent.height * 0.2
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
        y: iris.height / 10

        Shape {
            id: top_lid_shape
            anchors.fill: parent

            ShapePath {
                id: path
                fillColor: "black"
                strokeColor: "black"
                startX: -iris.width / 2
                startY: -eye.height / 2
                PathLine{
                    x: -iris.width / 2
                    y: eye.height / 2
                }
                PathArc {
                    id: top_arc
                    x: iris.width / 2
                    y: eye.height / 2
                    radiusX: 200; radiusY: iris.height / 20
                    useLargeArc: false
                    direction: PathArc.Clockwise
                    xAxisRotation: 0
                }
                PathLine{
                    x: iris.width / 2
                    y: 0
                }
                PathLine{
                    x: -iris.width / 2
                    y: 0
                }
            }
        }
    }
    Rectangle {
        id: bottom_lid
        anchors.horizontalCenter: parent.horizontalCenter
        y: -iris.height / 10

        Shape {
            id: bottom_lid_shape
            anchors.fill: parent

            ShapePath {
                id: p2
                fillColor: "black"
                strokeColor: "black"
                startX: -iris.width / 2
                startY: iris.height
                PathLine{
                    x: -iris.width / 2
                    y: eye.height / 2
                }
                PathArc {
                    id: bottom_arc
                    x: iris.width / 2
                    y: eye.height / 2
                    radiusX: 200; radiusY: iris.height / 20

                    useLargeArc: false
                    direction: PathArc.Counterclockwise
                    xAxisRotation: 0
                }
                PathLine{
                    x: iris.width / 2
                    y: eye.height
                }
                PathLine{
                    x: -iris.width / 2
                    y: eye.height
                }
            }
        }
    }
}
