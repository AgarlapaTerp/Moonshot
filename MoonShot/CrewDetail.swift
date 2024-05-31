//
//  CrewDetail.swift
//  MoonShot
//
//  Created by user256510 on 3/25/24.
//

import SwiftUI

struct CrewDetail: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
            .accessibilityElement()
            .accessibilityLabel("Picture of \(astronaut.name)")
            .accessibilityHint(astronaut.description)
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return CrewDetail(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
