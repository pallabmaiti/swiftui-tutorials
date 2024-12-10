//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by Pallab Maiti on 10/12/24.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .bottom) {
                    Text("\(user.name),")
                        .font(.largeTitle)
                        .bold()
                    Text("\(user.age)")
                        .font(.title)
                }
                Text(user.company)
                    .font(.title2)
                    .bold()
                Text(user.email)
                    .font(.title3)
            }
            Form {
                Section("Joining Date") {
                    Text(user.formattedRegistered)
                }
                Section("Address") {
                    Text(user.address)
                }
                Section("About") {
                    Text(user.about)
                }
                Section("Friends") {
                    List(user.friends) { friend in
                        Text("\(friend.name)")
                    }
                }
            }
        }
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let user = User(id: "test-id", isActive: true, name: "Test User", age: 25, company: "Test Company", email: "test@example.com", address: "Test Address", about: "Test About", registered: .now, tags: ["Test Tag"], friends: [Friend(id: "test-friend-id", name: "Test Friend")])
    return UserDetailsView(user: user)
}
