//
//  PhotoFaceApp.swift
//  PhotoFace
//
//  Created by Pallab Maiti on 16/12/24.
//

import SwiftUI

@main
struct PhotoFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Person.self)
        }
    }
}
