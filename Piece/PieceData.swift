//
//  PieceData.swift
//  Piece
//
//  Created by 김예림 on 4/14/24.
//

import Foundation
import SwiftUI

struct Piece: Codable, Identifiable {
    var id: UUID = UUID()
    var time: String
    var content: String
    //var imagesName: [String]
}
