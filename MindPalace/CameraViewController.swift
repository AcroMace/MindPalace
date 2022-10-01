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
    private var words: [String] = []
    private var wordsPlaced = 0 // index into words array

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

    func add(words: [String]) {
        self.words.append(contentsOf: words)
    }

    @objc func addLabel(_ sender: Any) {
        guard wordsPlaced < words.count else {
            return
        }

        let anchor = AnchorEntity(plane: .vertical,
                                  minimumBounds: [0.1, 0.1]) // This is in meters
        arView!.scene.addAnchor(anchor)

        let labelEntity = LabelEntity(text: words[wordsPlaced])

        // By default, the text is laid flat on the ground
        // We rotate it so that it's standing up / readable vertically
        let radians = -90.0 * Float.pi / 180.0
        labelEntity.transform.rotation *= simd_quatf(angle: radians, axis: SIMD3<Float>(1, 0, 0))

        // This is necessary for the objects not to be deallocated
        entities.append(labelEntity)
        anchor.addChild(labelEntity)

        wordsPlaced += 1
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
