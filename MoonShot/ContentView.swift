//
//  ContentView.swift
//  MoonShot
//
//  Created by user256510 on 3/23/24.
//

import SwiftUI

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission){
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                                .accessibilityLabel("picture of \(mission.displayname)")
                            VStack {
                                Text(mission.displayname)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.displayDate )
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                            .accessibilityElement()
                            .accessibilityLabel(mission.displayname)
                            .accessibilityHint(mission.displayDate)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay (
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                        .accessibilityAddTraits([.isLink,.isButton])
                    }
                    
                }
                
            }
            .padding([.horizontal, .bottom])
            .navigationDestination(for: Mission.self) {selection in
                MissionView(mission: selection, astronauts: astronauts)
            }
        }
        
    }
}

struct Listlayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    var body: some View {
        List(missions){ mission in
            NavigationLink(value: mission){
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                    VStack {
                        Text(mission.displayname)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.displayDate )
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
                .scrollContentBackground(.hidden)
                .background(.darkBackground)
            }
        }
//        .padding([.horizontal,.bottom])
        .scrollContentBackground(.hidden)
        .background(.darkBackground)
        .navigationDestination(for: Mission.self) { selection in
            MissionView(mission: selection, astronauts: astronauts)
        }
        
    }
}

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var gridOrList = true
    
//    let columns = [GridItem(.adaptive(minimum: 150))]
    
    
    var body: some View {
        NavigationStack {
            Group{
                if gridOrList {
                    GridLayout(astronauts: astronauts, missions: missions)
                    
                } else {
                    Listlayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button(gridOrList ? "List": "Grid") {
                        gridOrList.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
