/*
 *  Copyright 2013 Marco Martin <mart@kde.org>
 *  Copyright 2014 Sebastian Kügler <sebas@kde.org>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.11
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import org.kde.kquickcontrolsaddons 2.0
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kcmutils as KCM

KCM.GridDelegate {
    id: wallpaperDelegate
  
    property alias color: backgroundRect.color
    property bool selected: (wallpapersGrid.currentIndex == index)

	opacity: model.pendingDeletion ? 0.5 : 1
    text: model.display
    
    toolTip: model.author.length > 0 ? i18nd("plasma_wallpaper_org.kde.image", "%1 by %2", model.display, model.author) : ""

    hoverEnabled: true

    thumbnail: Rectangle {
        id: backgroundRect
        color: cfg_Color
        anchors.fill: parent

        Image {
            id: walliePreview            
            anchors.fill: parent
            asynchronous:true
            source: model.path
            fillMode: Image.PreserveAspectFit
            cache:true
            smooth:false
            sourceSize.width : units.gridUnit * 25
            sourceSize.height: units.gridUnit * 25
        }
    }

    onClicked: {
        cfg_Image = model.path;
        wallpapersGrid.forceActiveFocus();
    }
}
