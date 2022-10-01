//
//  CameraView.swift
//  MindPalace
//
//  Created by Andy Cho on 9/27/22.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {

    @Binding var wordModels: [WordModel]

    typealias UIViewControllerType = CameraViewController

    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraVC = CameraViewController()
        cameraVC.add(words: wordModels.map { $0.word })
        return cameraVC
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // no-op
    }

}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(wordModels: .constant([WordModel("Hello"), WordModel("There")]))
    }
}
