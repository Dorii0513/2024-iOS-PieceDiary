//
//  PieceApp.swift
//  Piece
//
//  Created by 김예림 on 4/13/24.
//

import SwiftUI

@main
struct PieceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView( selectedUIImage: .constant([]))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
