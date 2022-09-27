//
//  CameraViewController.swift
//  MindPalace
//
//  Created by Andy Cho on 9/27/22.
//

import UIKit
import SpriteKit
import ARKit

class CameraViewController: UIViewController {

    private var sceneView = ARSKView()
    private var scene: SKScene?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(sceneView)

        sceneView.delegate = self
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true

        scene = SKScene(fileNamed: "Scene")
        if let scene {
            sceneView.presentScene(scene)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        sceneView.frame = self.view.bounds
    }
}

// MARK: - ARSKViewDelegate

extension CameraViewController: ARSKViewDelegate {

    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        return nil
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        let alertController = UIAlertController(title: "AR session failed", message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        print("SESSION INTERRUPTED")
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        print("SESSION INTERRUPTION ENDED")
    }

}
