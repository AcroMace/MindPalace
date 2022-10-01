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
    private var entities: [Entity] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        arView = ARView(frame: view.bounds, cameraMode: .ar, automaticallyConfigureSession: true)
        if let arView {
            view.addSubview(arView)
            arView.session.delegate = self
        }

        let button = UIButton()
        button.setTitle("Add label", for: .normal)
        button.frame = CGRect(x: view.center.x / 2, y: 50, width: 100, height: 50)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(addLabel(_:)), for: .touchUpInside)
        view.addSubview(button)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let arView {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = [.horizontal, .vertical]
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

    @objc func addLabel(_ sender: Any) {
        let anchor = AnchorEntity(plane: .vertical,
                                   minimumBounds: [0.2, 0.2])
        arView!.scene.addAnchor(anchor)

        let labelEntity = LabelEntity(text: "Hello")
        let radians = -90.0 * Float.pi / 180.0
        labelEntity.transform.rotation *= simd_quatf(angle: radians, axis: SIMD3<Float>(1, 0, 0))
        // This is necessary for the objects not to be deallocated
        entities.append(labelEntity)
        anchor.addChild(labelEntity)
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
