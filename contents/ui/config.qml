import QtQuick 2.11
import org.kde.plasma.core 2.0 as PlasmaCore

import QtQuick.Controls 2.4 as QtControls
import QtQuick.Dialogs 1.1 as QtDialogs
import QtQuick.Window 2.0 // for Screen
import QtGraphicalEffects 1.0
import org.kde.plasma.wallpapers.image 2.0 as Wallpaper
import org.kde.kcm 1.1 as KCM
import org.kde.kirigami 2.4 as Kirigami
import org.kde.newstuff 1.1 as NewStuff



 Column {
	 id: root
	 anchors.fill:parent
	 property alias  cfg_Blur: blurCheckBox.checked
	 property alias  cfg_BlurRadius: blurRadiusSld.value
	 property alias  cfg_Color: colorDlg.color
	 property alias  cfg_Speed: animatedImageSpeedSld.value
	 property int    cfg_FillMode: Image.PreserveAspectFit
	 property string cfg_Image: "animation.webp"
	 property alias  cfg_DayNightColoring : dayNightColoringChkBox.checked
	 property alias  cfg_DayNightEffect: dayNightColorEffectSld.value
	 property alias  cfg_DayNightOffset: dayNightColoroffsetSld.value

	 spacing: units.largeSpacing

	 Wallpaper.Image {
		 id: imageWallpaper
		 targetSize: {
			 if (typeof plasmoid !== "undefined") {
				 return Qt.size(plasmoid.width, plasmoid.height)
			 }
			 // Lock screen configuration case
			 return Qt.size(Screen.width/5, Screen.height/5)
		 }
	 }

	 Row {
		 id: blurRow
		 anchors.horizontalCenter: parent.horizontalCenter
		 spacing: units.largeSpacing
		 Column {
			 id:configColumn
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
				 text:  i18nd("plasma_applet_org.kde.image","Enable blur of : %1px", blurRadiusSld.value);
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
			 QtControls.ComboBox {
				 id: resizeComboBox
				 anchors.left: parent.left
				 anchors.right: parent.right

				 model: [
				 {
					 'label': i18nd("plasma_wallpaper_org.kde.image", "Scaled and Cropped"),
					 'fillMode': Image.PreserveAspectCrop
				 },
				 {
					 'label': i18nd("plasma_wallpaper_org.kde.image", "Scaled"),
					 'fillMode': Image.Stretch
				 },
				 {
					 'label': i18nd("plasma_wallpaper_org.kde.image", "Scaled, Keep Proportions"),
					 'fillMode': Image.PreserveAspectFit
				 },
				 {
					 'label': i18nd("plasma_wallpaper_org.kde.image", "Centered"),
					 'fillMode': Image.Pad
				 },
				 {
					 'label': i18nd("plasma_wallpaper_org.kde.image", "Tiled"),
					 'fillMode': Image.Tile
				 }
				 ]

				 textRole: "label"
				 onCurrentIndexChanged: root.cfg_FillMode = model[currentIndex]["fillMode"]
				 Component.onCompleted: setMethod();

				 function setMethod() {
					 for (var i = 0; i < model.length; i++) {
						 if (model[i]["fillMode"] === wallpaper.configuration.FillMode) {
							 resizeComboBox.currentIndex = i;
							 return;
						 }
					 }
				 }
			 }
			 QtControls.CheckBox {
				 id: dayNightColoringChkBox
				 text:  i18nd("plasma_applet_org.kde.image","Enable Day/Night Tinting : %1 % ", dayNightColorEffectSld.value*100);
			 }
			 QtControls.Slider {
				 enabled: dayNightColoringChkBox.checked
				 id:dayNightColorEffectSld
				 live:true
				 stepSize: 0.01
				 snapMode:Slider.NoSnap
				 from: 0.01
				 value: 0.1
				 to: 1
			 }

			 QtControls.Slider {
				 visible: !wallpaper
				 enabled: dayNightColoringChkBox.checked
				 id:dayNightColoroffsetSld
				 live:true
				 from: 1
				 value: 43200
				 to: 86400
			 }
		 }

		 Row {
			 id: previewRow
			 spacing: units.largeSpacing / 2

			 Item {
				 width: height*(Screen.width/Screen.height)
				 height: configColumn.height
				 BackgoundComponent {
					 _animation.playing:(_animation.status == AnimatedImage.Ready )
					 source: root.cfg_Image
					 blurEnabled: blurCheckBox.checked
					 bkColor: root.cfg_Color
					 blurRadius: root.cfg_BlurRadius * (height/Screen.height*2)
					 animationSpeed:root.cfg_Speed
					 fillMode: root.cfg_FillMode
					 dayNightEnabled: root.cfg_DayNightColoring
					 dayNightEffect: root.cfg_DayNightEffect
					 dayNightOffset:root.cfg_DayNightOffset

				 }
			 }
		 }
	 }

	 Row {
		 id: imageSelectRow
		 Loader {
			 width:root.width - units.largeSpacing
			 height:root.height - configColumn.height - buttonsRow.height - units.largeSpacing * 2
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

			 anchors.margins: 4

			 view.delegate: WallpaperDelegate {
				 color: cfg_Color

				 actions: [
					Kirigami.Action {
						icon.name: "edit-undo"
						visible: model.pendingDeletion
						tooltip: i18nd("plasma_wallpaper_org.kde.image", "Restore wallpaper")
						onTriggered: imageWallpaper.wallpaperModel.setPendingDeletion(index, !model.pendingDeletion)
					},
					Kirigami.Action {
						icon.name: "edit-delete"
						tooltip: i18nd("plasma_wallpaper_org.kde.image", "Remove Wallpaper")
						visible: model.removable && !model.pendingDeletion
						onTriggered: {
							imageWallpaper.wallpaperModel.setPendingDeletion(index, true);
							if (wallpapersGrid.currentIndex === index) {
								wallpapersGrid.currentIndex = (index + 1) % wallpapersGrid.count;
							}
						}
					}
				 ]
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
			 text: i18nd("plasma_applet_org.kde.image","Add Local Wallpaper...")
			 onClicked: imageWallpaper.showFileDialog();
		 }
        QtControls.Button {
            visible: imageWallpaper.getNewWallpaper !== undefined
			icon.name: "get-hot-new-stuff"
			text: i18nd("plasma_applet_org.kde.image","Get New Wallpapers...")
			onClicked: imageWallpaper.getNewWallpaper();
		 }
		 NewStuff.Button {
            visible: imageWallpaper.getNewWallpaper === undefined
            configFile: "wallpaper.knsrc"
            text: i18nd("plasma_wallpaper_org.kde.image", "Get New Wallpapers...")
            viewMode: NewStuff.Page.ViewMode.Preview
            onChangedEntriesChanged: imageWallpaper.newStuffFinished();
        }
	 }


	//=======================================================
	function saveConfig() {
		imageWallpaper.commitDeletion();
	}

 }

