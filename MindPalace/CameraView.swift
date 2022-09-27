//
//  CameraView.swift
//  MindPalace
//
//  Created by Andy Cho on 9/27/22.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {

    typealias UIViewControllerType = CameraViewController

    func makeUIViewController(context: Context) -> CameraViewController {
        CameraViewController()
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // no-op
    }

}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
