//
//  Mission.swift
//  Moonshot
//
//  Created by Pallab Maiti on 18/11/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct Crew: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let crew: [Crew]
    let launchDate: Date?
    let description: String
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
}
