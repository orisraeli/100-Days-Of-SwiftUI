//
//  MissionView.swift
//  Moonshot
//
//  Created by Or Israeli on 20/04/2023.
//

import SwiftUI

struct MissionView: View {
	struct CrewMember {
		let role: String
		let astronaut: Astronaut
	}
	
	let mission: Mission
	let crew: [CrewMember]
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView {
				VStack {
					//Day 76 - Challenge 3
					Image(decorative: mission.image)
						.resizable()
						.scaledToFit()
						.frame(maxWidth: geometry.size.width * 0.6)
						.padding(.top)
					
					Text(mission.formattedLongLaunchDate)
						.font(.title2.bold())
						.padding()
					
					VStack(alignment: .leading) {
						MSDivider()
						
						Text("Mission Highlights")
							.font(.title.bold())
							.padding(.bottom, 5)
						
						Text(mission.description)
						
						MSDivider()
						
						Text("Crew")
							.font(.title.bold())
							.padding(.bottom, 5)
					}
					.padding(.horizontal)
					
					CrewView(crew: crew)
				}
				.padding(.bottom)
			}
		}
		.navigationTitle(mission.displayName)
		.navigationBarTitleDisplayMode(.inline)
		.background(.darkBackground)
	}
	
	init(mission: Mission, astronauts: [String: Astronaut]) {
		self.mission = mission
		
		self.crew = mission.crew.map { member in
			if let astronaut = astronauts[member.name] {
				return CrewMember(role: member.role, astronaut: astronaut)
			} else {
				fatalError("Missing \(member.name)")
			}
		}
	}
}

struct MissionView_Previews: PreviewProvider {
	static let missions: [Mission] = Bundle.main.decode("missions.json")
	static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
	
	static var previews: some View {
		MissionView(mission: missions[1], astronauts: astronauts)
			.preferredColorScheme(.dark)
	}
}
