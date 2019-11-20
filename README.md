# Animated Image wallpaper for KDE Plasma Desktop

# Installtion
- git clone git@github.com:dark-eye/com.darkeye.animatedImage.git
- plasmapkg2 --install com.darkeye.animatedImage


# Development

Just fork or clone the project :

`git clone git@github.com:dark-eye/com.darkeye.animatedImage.git`

Then you can apply/install you're changes by running : 

`plasmapkg2 --install com.darkeye.animatedImage`

And remove the installed wallpaper with

`plasmapkg2 --remove com.darkeye.animatedImage`


## General structure and notes:

- **metadata.desktop**: maetadata used to identify and escribe the wallpaper to plasma desktop
- **contents/ui/main.qml**: Main renderer of the wallpaper
- **contents/ui/config.qml**: The configuration form for the wallpaper
- **contents/ui/BackgroundComponent.qml**: The actual logic to display the wallpaper
- You can preview your QML files quickly with `qmlscene <file>.qml`.
- May need to logout then login again for the updated `main.qml` to take effect. Or try removing
  all `*.qmlc` files.

## TODOs
- Add speed configuration
- Find a better function for blur radius mapping from full screen to configuration preview

# Credits

This code was based on :

- Inspired mainly by com.nerdyweekly.animated wallpaper  that can be found [here](https://github.com/nhanb/com.nerdyweekly.animated)
- com.github.zren.inactiveblur the can be found [here](https://github.com/Zren/plasma-wallpapers/tree/master/inactiveblur)
