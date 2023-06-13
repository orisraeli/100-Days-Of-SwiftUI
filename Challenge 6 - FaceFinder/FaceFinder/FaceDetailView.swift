//
//  FaceDetailView.swift
//  FaceFinder
//
//  Created by Or Israeli on 27/05/2023.
//

import MapKit
import SwiftUI

struct FaceDetailView: View {
	var person: Person

	@State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36, longitude: 15), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
	
	
    var body: some View {
		NavigationStack {
			VStack {
				Spacer()
				
				Image(uiImage: person.image ?? UIImage())
					.resizable()
					.scaledToFit()
					.padding(.bottom)
								
				HStack {
					Text("Where we met?")
						.padding(.horizontal)
					Spacer()
				}
				
				Map(coordinateRegion: $mapRegion, annotationItems: [person]) { place in
					MapMarker(coordinate: place.coordinate)
				}
				.frame(minHeight: 150)
				.clipShape(RoundedRectangle(cornerRadius: 10))
				.padding([.horizontal])
			}
			.onAppear {
				mapRegion.center = person.coordinate
			}
			.navigationTitle(person.name)
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}

struct FaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
		FaceDetailView(person: Person(name: "Shmulik", location: Person.exampleLocation))
    }
}
