//
//  CrewView.swift
//  Moonshot
//
//  Created by Or Israeli on 21/04/2023.
//

import SwiftUI

struct CrewView: View {
	let crew: [MissionView.CrewMember]
	
    var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(crew, id: \.role) { crewMember in
					NavigationLink {
						AstronautView(astronaut: crewMember.astronaut)
					} label: {
						HStack {
							Image(crewMember.astronaut.id)
								.resizable()
								.frame(width: 104, height: 72)
								.clipShape(Circle())
								.overlay(
									Circle()
										.strokeBorder(.white, lineWidth: 1)
								)
							
							VStack(alignment: .leading) {
								Text(crewMember.astronaut.name)
									.foregroundColor(.white)
									.font(.headline)
								
								Text(crewMember.role)
									.foregroundColor(.secondary)
							}
						}
						.padding(.horizontal)
					}
				}
			}
		}
    }
}

struct CrewView_Previews: PreviewProvider {
	static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
	static let crew = [
		MissionView.CrewMember(role: "Commander", astronaut: astronauts["armstrong"]!),
		MissionView.CrewMember(role: "Commander", astronaut: astronauts["white"]!),
		MissionView.CrewMember(role: "Commander", astronaut: astronauts["grissom"]!)
	]
	
    static var previews: some View {
        CrewView(crew: crew)
			.preferredColorScheme(.dark)
    }
}
