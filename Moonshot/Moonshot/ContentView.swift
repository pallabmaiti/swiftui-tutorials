//
//  ContentView.swift
//  Moonshot
//
//  Created by Pallab Maiti on 18/11/24.
//

import SwiftUI
import Helpers

struct GridView: View {
    let mission: Mission
    
    var body: some View {
        VStack() {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
            
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
}

struct ListView: View {
    let mission: Mission
    
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding()
            
            VStack(spacing: 10) {
                Text(mission.displayName)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A")
                    .frame(maxWidth: .infinity)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
            .background(.lightBackground)
            
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
}

struct ContentView: View {
    @State private var gridView = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode(from: "astronauts.json")
    let missions: [Mission] = Bundle.main.decode(from: "missions.json")
    
    @State private var columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink() {
                            MissionDetailsView(mission: mission, astronauts: astronauts)
                        } label: {
                            if gridView {
                                GridView(mission: mission)
                            } else {
                                ListView(mission: mission)
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom], 5)
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("", systemImage: !gridView ? "circle.grid.3x3.circle" : "list.bullet.circle") {
                    withAnimation {
                        gridView.toggle()
                        columns = gridView ? [GridItem(.adaptive(minimum: 150))] : [GridItem(.adaptive(minimum: 300))]
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
