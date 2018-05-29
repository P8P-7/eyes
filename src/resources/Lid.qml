import QtQuick 2.0
import QtQuick.Shapes 1.10

Shape {
    id: lid

    property bool inverse: false

    ShapePath {
        fillColor: "red"
        strokeColor: "black"

        startX: -parent.width * 0.1
        startY: inverse ? parent.height + parent.height : -parent.height

        PathLine {
            x: -parent.width * 0.1
            y: parent.height / 2
        }
        PathArc {
            x: parent.width + parent.width * 0.1
            y: parent.height / 2

            radiusY: parent.height / 6
            radiusX: parent.width / 4

            direction: inverse ? PathArc.Counterclockwise : PathArc.Clockwise
        }
        PathLine {
            x: parent.width + parent.width * 0.1
            y: inverse ? parent.height + parent.height : -parent.height
        }
    }
}
