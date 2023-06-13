//
//  ContentView.swift
//  Moonshot
//
//  Created by Or Israeli on 18/04/2023.
//

import SwiftUI

struct ContentView: View {
	@State private var showingGridLayout = true
	
	let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
	let missions: [Mission] = Bundle.main.decode("missions.json")

	var body: some View {
		NavigationView {
			Group {
				if showingGridLayout {
					GridLayout(missions: missions, astronauts: astronauts)
				} else {
					ListLayout(missions: missions, astronauts: astronauts)
				}
			}
			.navigationTitle("Moonshot")
			.background(.darkBackground)
			.preferredColorScheme(.dark)
			.toolbar {
				Button {
					showingGridLayout.toggle()
				} label: {
					if showingGridLayout {
						Image(systemName: "list.bullet")
							//Day 76 - Challenge 3
							.accessibilityLabel("List layout")
							.accessibilityHint("Change into list layout")
					} else {
						Image(systemName: "circle.grid.2x2")
							//Day 76 - Challenge 3
							.accessibilityLabel("Grid layout")
							.accessibilityHint("Change into grid layout")
					}
				}
			}
		}
		.tint(.white)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
