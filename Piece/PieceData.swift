//
//  PieceData.swift
//  Piece
//
//  Created by 김예림 on 4/14/24.
//

import Foundation
import SwiftUI

//이미지 경로를 저장하자
struct Piece: Codable, Identifiable {
    var id: UUID = UUID()
    var time: String
    var content: String
    var imagesString: [String]
    //var imagesName: [String]
}
