//
//  LabelEntity.swift
//  MindPalace
//
//  Created by Andy Cho on 9/30/22.
//

import RealityKit

class LabelEntity: Entity, HasModel {

    required init(text: String) {
        super.init()

        model = ModelComponent(
            mesh: .generateText(text, extrusionDepth: 0.02, font: .boldSystemFont(ofSize: 0.1)),
            materials: [
                SimpleMaterial(color: .black, isMetallic: false)
            ]
        )
    }

    required init() {
        fatalError("Using the default init for LabelEntity which doesn't specify text")
    }

}
