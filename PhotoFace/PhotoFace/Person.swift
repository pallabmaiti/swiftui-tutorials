//
//  Person.swift
//  PhotoFace
//
//  Created by Pallab Maiti on 16/12/24.
//

import CoreLocation
import Foundation
import SwiftData
import SwiftUI

@Model
class Person: Identifiable {
    private(set) var id: UUID = UUID()
    var name: String
    @Attribute(.externalStorage) private(set) var imageData: Data
    var latitude: Double?
    var longitude: Double?
    
//    var location: CLLocationCoordinate2D? {
//        guard let latitude, let longitude else { return nil }
//        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
    
    var image: Image? {
        guard let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }
    
    init(name: String, imageData: Data, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.imageData = imageData
        if let coordinate {
            self.latitude = coordinate.latitude
            self.longitude = coordinate.longitude
        }
    }
}

