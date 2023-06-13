//
//  ListLayout.swift
//  Moonshot
//
//  Created by Or Israeli on 21/04/2023.
//

import SwiftUI

struct ListLayout: View {
	let missions: [Mission]
	let astronauts: [String: Astronaut]
	
	var body: some View {
		List {
			ForEach(missions) { mission in
				NavigationLink {
					MissionView(mission: mission, astronauts: astronauts)
				} label: {
					HStack {
							Image(mission.image)
								.resizable()
								.scaledToFit()
								.frame(width: 100, height: 100)
								.padding()
							
							VStack(alignment: .leading) {
								Text(mission.displayName)
									.font(.title)
									.foregroundColor(.white)
									.padding(.vertical, 2)
								
								Text(mission.formattedLaunchDate)
									.font(.headline)
									.foregroundColor(.white.opacity(0.5))
							}
							.padding(.vertical)
							.background(.lightBackground)
					}
				}
			}
			.listRowSeparator(.hidden)
			.listRowBackground(
				RoundedRectangle(cornerRadius: 30)
					.foregroundColor(.lightBackground)
					.padding(8)
			)
		}
		.listStyle(.plain)
		.background(.darkBackground)
	}
}

struct MissionListView_Previews: PreviewProvider {
	static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
	static let missions: [Mission] = Bundle.main.decode("missions.json")
	
	static var previews: some View {
		ListLayout(missions: missions, astronauts: astronauts)
	}
}
