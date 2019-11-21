 import QtQuick 2.12
import org.kde.plasma.core 2.0 as PlasmaCore

import QtQuick.Controls 2.12 as QtControls
import QtQuick.Dialogs 1.1 as QtDialogs
import QtQuick.Window 2.0 // for Screen
import QtGraphicalEffects 1.0
import org.kde.plasma.wallpapers.image 2.0 as Wallpaper
import org.kde.kcm 1.1 as KCM

Column {
    id: root
    property alias cfg_Blur: blurCheckBox.checked
    property alias cfg_BlurRadius: blurRadiusSld.value
    property alias cfg_Color: colorDlg.color
    property alias cfg_Speed: animatedImageSpeedSld.value
    property string cfg_Image: "animation.gif"

    spacing: units.largeSpacing

    Wallpaper.Image {
        id: imageWallpaper
        targetSize: {
            if (typeof plasmoid !== "undefined") {
                return Qt.size(plasmoid.width, plasmoid.height)
            }
            // Lock screen configuration case
            return Qt.size(Screen.width, Screen.height)
        }
    }

    Row {
        id: blurRow
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: units.largeSpacing
        Column {
            anchors.verticalCenter: parent.verticalCenter

            Row {
                    spacing: units.largeSpacing
                    QtDialogs.ColorDialog {
                        id:colorDlg
                        modality: Qt.WindowModal
                        showAlphaChannel: false
                        title: i18nd("plasma_applet_org.kde.image", "Select Background Color")

                    }
                    QtControls.Label {

                        anchors.verticalCenter: colorButton.verticalCenter
                        horizontalAlignment: Text.AlignRight
                        text: i18nd("plasma_applet_org.kde.image", "Background Color:")
                    }
                    QtControls.Button {
                        id: colorButton
                        width: units.gridUnit * 3
                        text: " " // needed to it gets a proper height...
                        onClicked: colorDlg.open()

                        Rectangle {
                            id: colorRect
                            anchors.centerIn: parent
                            width: parent.width - 2 * units.smallSpacing
                            height: theme.mSize(theme.defaultFont).height
                            color: colorDlg.color
                        }
                    }
            }


            QtControls.CheckBox {
                id: blurCheckBox
                text:  i18nd("plasma_applet_org.kde.blur","Enable blur of : %1px", blurRadiusSld.value);
            }

            QtControls.Slider {
                enabled: blurCheckBox.checked
                id:blurRadiusSld
                live:true
                stepSize: 1
                snapMode:Slider.NoSnap
                from: 1
                value: 40
                to: 100
            }

            Column {

                QtControls.Label {
                    anchors.verticalCenter: colorButton.verticalCenter
                    horizontalAlignment: Text.AlignRight
                    text: i18nd("plasma_applet_org.kde.image", "Image Animation speed : %1",animatedImageSpeedSld.value)
                }
                QtControls.Slider {
                    id:animatedImageSpeedSld
                    live:true
                    stepSize: 0.1
                    from: 0.1
                    value: 1
                    to: 3
                }
            }
        }

        Row {
            id: previewRow
            spacing: units.largeSpacing / 2

            Item {
                width: height*(Screen.width/Screen.height)
                height: root.height/3
                BackgoundComponent {
                   source: root.cfg_Image
                   blurEnabled: blurCheckBox.checked
                   bkColor: root.cfg_Color
                   blurRadius: root.cfg_BlurRadius * (height/Screen.height*2)
                   animationSpeed:root.cfg_Speed
                }
            }
        }
    }

    Row {
        id: imageSelectRow
        Loader {
            width:root.width - units.largeSpacing
            height:root.height/2
            asynchronous: true
            sourceComponent: wallpaperGridComp
        }
    }

    Component {
        id:wallpaperGridComp
        KCM.GridView {
            id: wallpapersGrid
            anchors.fill: parent
            view.model: imageWallpaper.wallpaperModel

            view.currentIndex:  Math.min(imageWallpaper.wallpaperModel.indexOf(cfg_Image), imageWallpaper.wallpaperModel.count-1)
            focus: true

            //cellWidth: Math.max(root.width / 5, 160)
            //cellHeight: Math.max(root.height / 5, 80)

            anchors.margins: 4
           // boundsBehavior: Flickable.StopAtBounds

            view.delegate: WallpaperDelegate {
                color: cfg_Color
            }
        }
    }

Row {
        id: buttonsRow
        anchors {
            right: parent.right
        }
        QtControls.Button {
            icon.name: "document-open-folder"
            text: i18nd("plasma_applet_org.kde.image","Open...")
            onClicked: imageWallpaper.showFileDialog();
        }
        QtControls.Button {
            icon.name: "get-hot-new-stuff"
            text: i18nd("plasma_applet_org.kde.image","Get New Wallpapers...")
            onClicked: imageWallpaper.getNewWallpaper();
        }
    }

}
