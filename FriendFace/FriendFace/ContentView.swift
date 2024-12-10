//
//  ContentView.swift
//  FriendFace
//
//  Created by Pallab Maiti on 09/12/24.
//

import SwiftData
import SwiftUI
import Helpers

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink {
                    UserDetailsView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text("\(user.name)")
                            .font(.title2)
                        Text("\(user.email)")
                            .font(.title3)
                    }
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func loadData() async {
        if !users.isEmpty {
            return
        }
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let users: [User] = data.decode()
            for user in users {
                modelContext.insert(user)
            }
        } catch {
            print("Invalid JSON: \(error.localizedDescription)")
        }
    }
}

#Preview {
    return ContentView()
}
