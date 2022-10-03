# Mind Palace

Add text to various surfaces in your home

## Getting started

1. Open MindPalace.xcodeproj
2. Compile and run **on a real device**

The real device part is important as the project will fail to compile on the simulator because `AnchorEntity` is not available.

## Files

- `CameraViewController.swift` has all the actual logic for the AR stuff
- `ContentView.swift` is a SwiftUI file where the list of words is updated before being passed to the Camera VC.

## Notes

It seems like when the anchor is placed, it waits until a vertical plane is recognized, and then it places it approximately at the center of the screen on the vertical plane. There's likely a smarter way of doing this, but right now there's no plane recognition before placement, it's all automatic.
