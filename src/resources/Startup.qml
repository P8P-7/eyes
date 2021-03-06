import QtQuick 2.9
import QtQuick.Shapes 1.0
import QtQuick.Layouts 1.3

Item {
    id: startup_wapper

    Timer {
        id: blink_timer
        interval: 4800; running: true; repeat: false
        onTriggered: visible = false
    }

    Timer {
        id: start_timer
        interval: 2000; running: true; repeat: false
        onTriggered: animation.playing = true
    }

    AnimatedImage {
        id: animation
        playing: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "logo_animation.gif"
        width: (window.width >= 800) ? 800 : window.width
        height: (window.height >= 450) ? 450 : window.height
    }
}
