//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Or Israeli on 11/06/2023.
//

import SwiftUI

struct ResortView: View {
	let resort: Resort
	
	@Environment(\.horizontalSizeClass) var sizeClass
	@Environment(\.dynamicTypeSize) var typeSize
	@EnvironmentObject var favorites: Favorites
	
	@State private var selectedFacility: Facility?
	@State private var showingFacility = false
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				Image(decorative: resort.id)
					.resizable()
					.scaledToFit()
					//Day 99 - Challenge 1
					.overlay {
						VStack {
							Spacer()
							
							HStack {
								Spacer()
								
								Text("Credit: \(resort.imageCredit)")
									.foregroundColor(.white)
									.padding(2)
									.background(.black.opacity(0.5))
									.clipShape(RoundedRectangle(cornerRadius: 5))
							}
						}
					}
				
				HStack {
					if sizeClass == .compact && typeSize > .large {
						VStack(spacing: 10) { ResortDetailView(resort: resort) }
						VStack(spacing: 10) { SkiDetailView(resort: resort) }
					} else {
						HStack {
							ResortDetailView(resort: resort)
							SkiDetailView(resort: resort)
						}
					}
				}
				.padding(.vertical)
				.background(Color.primary.opacity(0.1))
				
				Group {
						Text(resort.description)
						.padding(.vertical)
						
						Text("Facilities")
							.font(.headline)
						
					HStack {
						ForEach(resort.facilityTypes) { facility in
							Button {
								selectedFacility = facility
								showingFacility = true
							} label: {
								facility.icon
									.font(.title)
							}
						}
					}
					.frame(maxWidth: .infinity)
				}
				.padding(.horizontal)
			}
			
			VStack(alignment: .center) {
				Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
					if favorites.contains(resort) {
						favorites.remove(resort)
					} else {
						favorites.add(resort)
					}
				}
				.buttonStyle(.borderedProminent)
				.padding()
			}
		}
		.navigationTitle("\(resort.name), \(resort.country)")
		.navigationBarTitleDisplayMode(.inline)
		.alert(selectedFacility?.name ?? "More Information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
		} message: { facility in
			Text(facility.description)
		}
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			ResortView(resort: Resort.example)
		}
		.environmentObject(Favorites())
    }
}
