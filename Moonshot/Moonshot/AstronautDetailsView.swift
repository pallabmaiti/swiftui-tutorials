//
//  AstronautDetailsView.swift
//  Moonshot
//
//  Created by Pallab Maiti on 19/11/24.
//

import SwiftUI

struct AstronautDetailsView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            Image(astronaut.id)
                .resizable()
                .scaledToFit()
            
            Text(astronaut.description)
                .font(.body)
                .foregroundStyle(.white)
                .padding()
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode(from: "astronauts.json")
    return AstronautDetailsView(astronaut: astronauts["grissom"]!)
}
