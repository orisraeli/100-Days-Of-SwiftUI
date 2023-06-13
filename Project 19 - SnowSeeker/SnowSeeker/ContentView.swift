//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Or Israeli on 10/06/2023.
//

import SwiftUI

struct ContentView: View {
	let resorts: [Resort] = Bundle.main.decode("resorts.json")

	@StateObject var favorites = Favorites()
	@State private var searchQuery = ""
	@State private var isPresentingSortOptions = false
	@State private var sortBy = SortingOptions.normal
	
	enum SortingOptions {
		case alphabetical, normal, country
	}
	
	var body: some View {
		NavigationSplitView {
			List(filteredResorts) { resort in
				NavigationLink {
					ResortView(resort: resort)
				} label: {
					HStack {
						Image(resort.country)
							.resizable()
							.scaledToFill()
							.frame(width: 40, height: 25)
							.clipShape(RoundedRectangle(cornerRadius: 5))
							.overlay(
								RoundedRectangle(cornerRadius: 5)
									.stroke(.black, lineWidth: 1)
							)
						
						VStack(alignment: .leading) {
							Text(resort.name)
								.font(.headline)
							Text("\(resort.runs) runs")
								.foregroundColor(.secondary)
						}
						
						if favorites.contains(resort) {
							Spacer()
							
							Image(systemName: "heart.fill")
								.foregroundColor(.red)
								.accessibilityLabel("This is a favorite resort.")
						}
					}
				}
			}
			.navigationTitle("Resorts")
			.searchable(text: $searchQuery, prompt: "Search for a resort")
			.toolbar {
				Button {
					isPresentingSortOptions = true
				} label: {
					Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
				}
			}
			//Day 99 - Challenge 3
			.confirmationDialog("Sort by", isPresented: $isPresentingSortOptions) {
				Button("Alphabetical") { sortBy = .alphabetical }
				Button("Country") { sortBy = .country }
				Button("Default") { sortBy = .normal }
			}
		} detail: {
			WelcomeView()
		}
		.environmentObject(favorites)
	}
	
	var sortedResorts: [Resort] {
		switch sortBy {
			case .alphabetical:
				return resorts.sorted { $0.name < $1.name }
			case .country:
				return resorts.sorted { $0.country < $1.country }
			default:
				return resorts
		}
	}
	
	var filteredResorts: [Resort] {
		if searchQuery.isEmpty {
			return sortedResorts
		} else {
			return sortedResorts.filter { $0.name.localizedStandardContains(searchQuery)}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
