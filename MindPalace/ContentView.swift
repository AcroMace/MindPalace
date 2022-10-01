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

    @State private var wordModels: [WordModel] = [WordModel("Hello"), WordModel("There")]

    var body: some View {
        NavigationView {
            VStack {
                List(wordModels) { wordModel in
                    HStack {
                        Text(wordModel.word)
                    }
                }
            }
            .navigationTitle(Text("Mind Palace"))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("+") {
                        print("Pressed +")
                    }
                }

                ToolbarItem(placement: .bottomBar) {
                    NavigationLink("View") {
                        CameraView(wordModels: $wordModels)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
