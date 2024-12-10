//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Pallab Maiti on 09/12/24.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
