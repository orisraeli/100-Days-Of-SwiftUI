//
//  ContentView.swift
//  FaceFinder
//
//  Created by Or Israeli on 19/05/2023.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
	@StateObject var people = People()
	
	@State private var isPresentingImagePicker = false
	@State private var image: UIImage?
	@State private var isPresentingAlert = false
	@State private var name = ""
	@State private var someLocation = Person.exampleLocation
	
	let locationFetcher = LocationFetcher()
	
	var body: some View {
		NavigationStack {
			VStack {
				List {
					ForEach(people.items.sorted()) { person in
						NavigationLink {
							FaceDetailView(person: person)
						} label: {
							HStack {
								Image(uiImage: person.image ?? UIImage(systemName: "person")!)
									.resizable()
									.scaledToFit()
									.clipShape(Circle())
									.frame(width: 80)
								
								Text(person.name)
							}
						}
					}
				}
			}
			.navigationTitle("FaceFinder")
			.sheet(isPresented: $isPresentingImagePicker) {
				ImagePicker(image: $image)
			}
			.onChange(of: image) { _ in isPresentingAlert = true }
			.toolbar {
				Button {
					isPresentingImagePicker = true
					self.locationFetcher.start()
				} label: {
					Label("Add", systemImage: "plus")
				}
			}
			.alert("New Face", isPresented: $isPresentingAlert) {
				TextField("Name", text: $name)
				Button("Add") {
					if name.isEmpty {
						name = "New Face"
					}
					
					let location = self.locationFetcher.lastKnownLocation
					var person = Person(name: name, location: location ?? someLocation)
					person.image = image
					people.add(person: person)
					
					name = ""
				}
				
				Button("Cancel", role: .cancel) {
					name = ""
				}
			} message: {
				Text("Name this face")
			}
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
