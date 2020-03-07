# Animated Image wallpaper for KDE Plasma Desktop

# Installtion
```
git clone git@github.com:dark-eye/com.darkeye.animatedImage.git
plasmapkg2 --install com.darkeye.animatedImage
```

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

### Resources

- Some good animations can be found at [Floris Kloet](https://livingstills.tumblr.com/)  (Checkout his archive)
  
## TODOs
- Customized tint gradinet

# Credits

This code was based on :

- Inspired mainly by com.nerdyweekly.animated wallpaper  that can be found [here](https://github.com/nhanb/com.nerdyweekly.animated)
- And some of com.github.zren.inactiveblur the can be found [here](https://github.com/Zren/plasma-wallpapers/tree/master/inactiveblur) was use for the image selection and kde integrestion



![donation widget](http://img.shields.io/liberapay/receives/darkeye.svg?logo=liberapay)

If you can and found this software helpful please [Donate](https://liberapay.com/darkeye/). 
