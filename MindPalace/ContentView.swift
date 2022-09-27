//
//  ContentView.swift
//  MindPalace
//
//  Created by Andy Cho on 9/26/22.
//

import SwiftUI

enum NavigationDestination {
    case CameraView
}

struct ContentView: View {
    @State private var isShowingCameraView = false

    var body: some View {
        NavigationView {
            VStack {
                /**
                 * This is weird but it's not rendered
                 * We use this to activate the segue to CameraView depending on $isShowingCameraView
                 * which we trigger with the navigation button
                 */
                NavigationLink(destination: CameraView(), isActive: $isShowingCameraView) {
                    EmptyView()
                }

                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")

                Button("View") {
                    isShowingCameraView = true
                }
            }
            .padding()
            .navigationTitle(Text("Mind Palace"))
            .toolbar {
                EditButton()
            }
            .navigationDestination(for: NavigationDestination.self) { _ in
                // This is the only case so far
                CameraView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
