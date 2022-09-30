//
//  WordModel.swift
//  MindPalace
//
//  Created by Andy Cho on 9/30/22.
//

import Foundation
import SwiftUI

struct WordModel: Hashable, Codable, Identifiable {
    var id: String
    var word: String

    init(_ word: String) {
        self.id = UUID().uuidString
        self.word = word
    }
}
