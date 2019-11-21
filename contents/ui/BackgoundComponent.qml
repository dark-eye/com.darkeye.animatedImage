import QtQuick 2.11
import org.kde.plasma.core 2.0 as PlasmaCore
import QtGraphicalEffects 1.0

Item {
    id: backgroundRoot

    property alias source: animation.source
    property bool blurEnabled: wallpaper.configuration.Blur
    property var bkColor: wallpaper.configuration.Color
    property var animationSpeed: wallpaper.configuration.Speed
    property var blurRadius: wallpaper.configuration.BlurRadius

    anchors.fill:parent
    Rectangle {
        id:bkRect
        anchors.fill:parent
        color: backgroundRoot.bkColor

        AnimatedImage {
            id: animation
            anchors.fill:parent

            smooth: true
            cache: true

            source: wallpaper.configuration.Image
            fillMode: Image.PreserveAspectFit
            speed:backgroundRoot.animationSpeed

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
