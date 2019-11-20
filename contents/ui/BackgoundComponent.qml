import QtQuick 2.5
import org.kde.plasma.core 2.0 as PlasmaCore
import QtGraphicalEffects 1.0

Item {
    id: backgroundRoot

    property alias source: animation.source
    property bool blurEnabled: wallpaper.configuration.Blur
    property var bkColor: wallpaper.configuration.Color
    property var blurRadius: wallpaper.configuration.BlurRadius

    anchors.fill:parent
    Rectangle {
        id:bkRect
        anchors.fill:parent
        color: backgroundRoot.bkColor

        AnimatedImage {
            id: animation
            anchors.fill:parent
            source: wallpaper.configuration.Image
            fillMode: Image.PreserveAspectFit
            smooth: true
            cache: true
            onStatusChanged: playing = (status == AnimatedImage.Ready)
        }
    }
    FastBlur {
        id: blur

        visible: backgroundRoot.blurEnabled
        enabled: visible

        anchors.fill: bkRect

        source: bkRect
        radius: backgroundRoot.blurRadius
    }
}
