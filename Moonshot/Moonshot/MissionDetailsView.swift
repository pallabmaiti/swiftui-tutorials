//
//  MissionDetailsView.swift
//  Moonshot
//
//  Created by Pallab Maiti on 19/11/24.
//

import SwiftUI

struct DividerView: View {
    let height: CGFloat = 2
    let color: Color = .lightBackground
    
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundStyle(color)
            .padding(.bottom, 5)
    }
}

struct MissionDetailsView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crewMembers: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        width * 0.6
                    }
                    .padding(.vertical)
                
                
                VStack(alignment: .leading) {
                    DividerView()
                    
                    Text("Launch Date")
                        .font(.title.bold())
                        .padding(.bottom)
                    
                    Text(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A")
                        .font(.headline)
                    
                    DividerView()
                    
                    Text("Mission History")
                        .font(.title.bold())
                        .padding(.bottom)
                    
                    Text(mission.description)
                        .font(.body)
                    
                    DividerView()
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(crewMembers, id: \.role) { crewMember in
                        NavigationLink {
                            AstronautDetailsView(astronaut: crewMember.astronaut)
                        } label: {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay {
                                        Capsule()
                                            .stroke(.white, lineWidth: 1)
                                    }
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(crewMember.role)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .background(.darkBackground)
        .preferredColorScheme(.dark)
        .navigationBarTitle(mission.displayName, displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crewMembers = mission.crew.map({ crew in
            if let astronaut = astronauts[crew.name] {
                return CrewMember(role: crew.role, astronaut: astronaut)
            } else {
                fatalError("Could not find astronaut for \(crew.name)")
            }
        })
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode(from: "missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode(from: "astronauts.json")
    return MissionDetailsView(mission: missions[0], astronauts: astronauts)
}
