//
//  EditPersonDetailsView.swift
//  PhotoFace
//
//  Created by Pallab Maiti on 19/12/24.
//

import MapKit
import PhotosUI
import SwiftData
import SwiftUI

struct EditPersonDetailsView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var person: Person
    
    @State private var startPosition: MapCameraPosition?
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var selectedItem: PhotosPickerItem?
    @State private var userImageData: Data
    
    @Query var persons: [Person]
    
    init(person: Person) {
        self.person = person
        if let latitude = person.latitude, let longitude = person.longitude {
            self.startPosition = .region(
                .init(
                    center: CLLocationCoordinate2D(
                        latitude: latitude,
                        longitude: longitude
                    ),
                    span: MKCoordinateSpan(
                        latitudeDelta: 10,
                        longitudeDelta: 10
                    )
                )
            )
            self.userLocation = CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            )
        }
        self.userImageData = person.imageData
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $person.name)
                }
                
                Section("Photo") {
                    ZStack(alignment: .topTrailing) {
                        if let uiImage = UIImage(data: userImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                        }
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundStyle(.white)
                                .frame(width: 34, height: 34)
                                .background(.black.opacity(0.75))
                                .clipShape(.circle)
                                .shadow(color: .black, radius: 5)
                        }
                    }
                }
                
                if let initialPosition = startPosition {
                    Section("Location") {
                        MapReader { proxy in
                            Map(initialPosition: initialPosition) {
                                if let coordinate = userLocation {
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
                            }
                            .frame(height: 400)
                            .onTapGesture { position in
                                if let coordinate = proxy.convert(position, from: .local) {
                                    userLocation = coordinate
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Edit Person Details")
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
            .onChange(of: selectedItem, loadImage)
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            self.userImageData = imageData
            self.selectedItem = nil
        }
    }
    
    func save() {
        let newPerson = Person(name: person.name, imageData: userImageData, coordinate: userLocation)
        if let index = persons.firstIndex(of: person) {
            var persons = self.persons
            persons[index] = newPerson
            do {
                try modelContext.delete(model: Person.self)
                for person in persons {
                    modelContext.insert(person)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        dismiss()
    }
}

#Preview {
    let person = Person(name: "Test Person", imageData: UIImage(named: "example")!.pngData()!, coordinate: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2088))
    EditPersonDetailsView(person: person)
}
