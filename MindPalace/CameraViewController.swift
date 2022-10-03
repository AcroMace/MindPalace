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

    private static let NextWordViewHeight = 40.0
    private static let NextWordButtonWidth = 100.0
    private static let NextWordPadding = 16.0
    private static let NextWordGradientHeight = 80.0

    private var arView: ARView?
    private var entities: [Entity] = []
    private var words: [String] = []
    private var wordsPlaced = 0 // index into words array

    private let nextWordView = UIView()
    private let nextWordLabel = UILabel()
    private let nextWordButton = UIButton()
    private let gradientView = UIView()
    private let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        arView = ARView(frame: view.bounds, cameraMode: .ar, automaticallyConfigureSession: true)
        if let arView {
            view.addSubview(arView)
        }

        let gradientColors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.colors = gradientColors
        gradientView.layer.addSublayer(gradientLayer)
        view.addSubview(gradientView)

        nextWordButton.setTitle("Place", for: .normal)
        nextWordButton.addTarget(self, action: #selector(addLabel(_:)), for: .touchUpInside)
        nextWordButton.backgroundColor = .systemGray

        nextWordButton.layer.cornerRadius = 8
        nextWordView.addSubview(nextWordLabel)
        nextWordView.addSubview(nextWordButton)
        view.addSubview(nextWordView)
        updateNextWordView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let arView {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = [.horizontal, .vertical]
            arView.session.run(configuration)
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

        gradientView.frame =
        CGRect(x: 0,
               y: view.frame.height - Self.NextWordGradientHeight,
               width: view.frame.width,
               height: Self.NextWordGradientHeight)
        gradientLayer.frame = gradientView.bounds

        nextWordView.frame =
        CGRect(x: 0,
               y: view.frame.height - Self.NextWordViewHeight - Self.NextWordPadding,
               width: view.frame.width,
               height: Self.NextWordViewHeight)

        nextWordButton.frame =
        CGRect(x: view.frame.width - Self.NextWordButtonWidth,
               y: 0,
               width: Self.NextWordButtonWidth - Self.NextWordPadding,
               height: Self.NextWordViewHeight)

        nextWordLabel.frame =
        CGRect(x: Self.NextWordPadding,
               y: 0,
               width: view.frame.width - Self.NextWordButtonWidth - Self.NextWordPadding * 2,
               height: Self.NextWordViewHeight)
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
        updateNextWordView()
    }

    private func updateNextWordView() {
        guard wordsPlaced < words.count else {
            nextWordView.isHidden = true
            return
        }
        nextWordView.isHidden = false

        nextWordLabel.text = "Placing word: \(words[wordsPlaced])"
    }
}
