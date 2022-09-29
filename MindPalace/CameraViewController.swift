//
//  CameraViewController.swift
//  MindPalace
//
//  Created by Andy Cho on 9/27/22.
//

import UIKit
import RealityKit
import ARKit

class CameraViewController: UIViewController {

    private var arView: ARView?

    override func viewDidLoad() {
        super.viewDidLoad()

        arView = ARView(frame: view.bounds, cameraMode: .ar, automaticallyConfigureSession: true)
        if let arView {
            view.addSubview(arView)
            arView.session.delegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let arView {
            let configuration = ARWorldTrackingConfiguration()
            arView.session.run(configuration)
            arView.session.delegate = self
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let arView {
            arView.session.pause()
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        arView?.frame = self.view.bounds
    }
}

// MARK: - ARSessionDelegate

extension CameraViewController: ARSessionDelegate {

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // no-op
    }

    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // no-op
    }

    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // no-op
    }

    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        // no-op
    }

}
