# Mind Palace

Add text to various surfaces in your home

![MindPalace demo gif](https://github.com/AcroMace/MindPalace/raw/master/Demo.gif)

## Getting started

1. Open MindPalace.xcodeproj
2. Compile and run **on a real device**

The real device part is important as the project will fail to compile on the simulator because `AnchorEntity` is not available.

## Files

- `CameraViewController.swift` has all the actual logic for the AR stuff
- `ContentView.swift` is a SwiftUI file where the list of words is updated before being passed to the Camera VC.

## Notes

It seems like when the anchor is placed, it waits until a vertical plane is recognized, and then it places it approximately at the center of the screen on the vertical plane. There's likely a smarter way of doing this, but right now there's no plane recognition before placement, it's all automatic.

The vertical plane recognition seems like it doesn't work super well on my iPhone SE, but works well on the iPad Pro. I don't know why this is the case. Maybe it's not supported without LIDAR?

It's relatively easy to add support for horizontal planes (see `addLabel`), but the text is currently rotated assuming it's a vertical plane. You'd need to know the currently viewed plane to know whether or not to rotate.
