//
//  MissionView.swift
//  MoonShot
//
//  Created by user256510 on 3/25/24.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct CustomDivider: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

struct AstronautView: View {
    let crew: [CrewMember]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(value:crewMember.astronaut){
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.circle)
                                .accessibilityLabel("Picture of \(crewMember.astronaut.name)")
                                
                                .overlay(Circle()
                                    .strokeBorder( .white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundStyle(crewMember.role == "Commander" ? Color.teal : .gray)
                            }
                            .accessibilityElement()
                            .accessibilityLabel("Astronaut \(crewMember.astronaut.name), \(crewMember.role)")
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                        .background(.lightBackground)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(.white))
                        .accessibilityAddTraits([.isLink, .isButton])
                    }
                }
            }
            
        }
        .navigationDestination(for: Astronaut.self) { selection in
            CrewDetail(astronaut: selection)
        }
        
        
    }
}

struct MissionView: View {
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                
                CustomDivider()
                
                VStack(alignment: .leading){
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.displayDate)
                    
                    Text(mission.description)
                    
                    CustomDivider()
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                
                AstronautView(crew: crew)
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayname)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            
            fatalError()
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
    
}
