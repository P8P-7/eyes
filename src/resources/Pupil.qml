import QtQuick 2.0

Rectangle {
    width: parent.width / 5
    height: parent.width / 5
    color: "black"
    radius: width * 0.5

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    Rectangle {
       width: parent.width / 4
       height: parent.height / 4
       color: "white"
       radius: width * 0.5

       x: parent.width / 2
       y: parent.width / 4
    }
}
