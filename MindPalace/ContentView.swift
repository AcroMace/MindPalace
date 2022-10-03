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
    private let WordToAddHorizontalPadding: CGFloat = 16.0

    @State private var isShowingCameraView = false

    @State private var wordModels: [WordModel] = []
    @State private var wordToAdd: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Write something you want to remember" /* placeholder */, text: $wordToAdd)
                    Button("Add", action: {
                        wordModels.append(WordModel(wordToAdd))
                        wordToAdd = ""
                    })
                }
                .padding(EdgeInsets(top: 0, leading: WordToAddHorizontalPadding, bottom: 0, trailing: WordToAddHorizontalPadding))

                List(wordModels) { wordModel in
                    HStack {
                        Text(wordModel.word)
                    }
                }

                NavigationLink("View") {
                    CameraView(wordModels: $wordModels)
                }
                .padding()
            }
            .navigationTitle(Text("Mind Palace"))
            // If we don't do this then the navigation bar is huge in the camera VC
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
