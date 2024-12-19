//
//  AddPersonDetailsView.swift
//  PhotoFace
//
//  Created by Pallab Maiti on 17/12/24.
//

import CoreLocation
import MapKit
import SwiftData
import SwiftUI

struct AddPersonDetailsView: View {
    @Bindable var person: Person
    
    @Query var persons: [Person]
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    private let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 23.5159,
                longitude: 83.3380),
            span: MKCoordinateSpan(
                latitudeDelta: 30,
                longitudeDelta: 30
            )
        )
    )
    
    private let userLocationFetcher = UserLocationFetcher()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $person.name)
                }
                
                Section("Photo") {
                    person.image?
                        .resizable()
                        .scaledToFit()
                }
                
                if let coordinate = userLocationFetcher.lastKnownLocation {
                    Section("Location") {
                        Map(initialPosition: startPosition) {
                            Annotation(person.name, coordinate: coordinate) {
                                person.image?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .background(.black)
                                    .clipShape(.circle)
                                    .overlay {
                                        Circle()
                                            .stroke(.black)
                                    }
                            }
                        }
                        .frame(height: 400)
                    }
                }
            }
            .onAppear(perform: userLocationFetcher.start)
            .navigationTitle("Add Person Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    save()
                } label: {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }
                .disabled(person.name.isEmpty)
            }
        }
    }
    
    func save() {
        guard let location = userLocationFetcher.lastKnownLocation else { return }
        let newPerson = Person(name: person.name, imageData: person.imageData, coordinate: location)
        modelContext.insert(newPerson)
        dismiss()
    }
}

#Preview {
    let person = Person(name: "", imageData: UIImage(named: "example")!.pngData()!, coordinate: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2088))
    AddPersonDetailsView(person: person)
}
