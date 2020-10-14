import QtQuick 2.11
import org.kde.plasma.core 2.0 as PlasmaCore
import QtGraphicalEffects 1.0
import QtQuick.Window 2.0 // for Screen


Item {
    id: root

    width: Screen.width
    height: Screen.height
    
    WindowModel {
        id:windowModel
    }
    
    Timer {
        id:timeOffsetUpdateTimer
        interval:600000
        repeat:true
        running:true
        onTriggered: {
            backgroundComponent.timeoffestForDayNight =  (Date.now()+(backgroundComponent.dayNightOffset*1000)+(new Date()).getTimezoneOffset())%86400000/86400000;
        }
    }
    
    
    BackgoundComponent {
        id:backgroundComponent
        _animation.playing: _animation.status == AnimatedImage.Ready && (!wallpaper.configuration.StopAnimOnHide || !windowModel.currentWindowMaximized) 
//         source: wallpaper.configuration.Image
//         blurEnabled: wallpaper.configuration.Blur
//         bkColor: wallpaper.configuration.Color
//         blurRadius: wallpaper.configuration.BlurRadius
//         cacheImageAnyway: wallpaper.configuration.CacheImageAnyway
    }
}
