//
//  ContentView.swift
//  PhotoFace
//
//  Created by Pallab Maiti on 16/12/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Person.name) var persons: [Person]
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var person: Person?
    
    var body: some View {
        NavigationStack {
            VStack {
                if persons.isEmpty {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        ContentUnavailableView("No Photos", systemImage: "photo.badge.plus", description: Text("Tap to import photos"))
                    }
                } else {
                    List {
                        ForEach(persons) { person in
                            NavigationLink(destination: EditPersonDetailsView(person: person)) {
                                HStack {
                                    person.image?
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(.rect(cornerRadius: 10))
                                    Text(person.name)
                                }
                            }
                        }
                        .onDelete(perform: deletePerson)
                    }
                }
            }
            .buttonStyle(.plain)
            .onChange(of: selectedItem, loadImage)
            .sheet(item: $person) { person in
                AddPersonDetailsView(person: person)
            }
            .navigationTitle("PhotoFace")
            .toolbar {
                if !persons.isEmpty {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            let person = Person(name: "", imageData: imageData)
            self.person = person
            self.selectedItem = nil
        }
    }
    
    func deletePerson(at offsets: IndexSet) {
        for offset in offsets {
            let person = persons[offset]
            modelContext.delete(person)
        }
    }
}

#Preview {
    ContentView()
}
