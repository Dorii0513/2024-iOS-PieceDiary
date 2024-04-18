//
//  save.swift
//  Piece
//
//  Created by 김예림 on 4/17/24.
//

import Foundation
import SwiftUI

struct pieceSave{
    
    @Binding var pieceList: [Piece]
    
    func loadList() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("piece.json")
        if let data = try? Data(contentsOf: fileURL) {
            if let decoded = try? JSONDecoder().decode([Piece].self, from: data) {
                self.pieceList = decoded
            }
        }
    }
    
    // UserDefaults에 데이터를 저장하는 함수
    func saveList() {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("piece.json")
        if let encodedData = try? JSONEncoder().encode(pieceList) {
            try? encodedData.write(to: fileURL)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
