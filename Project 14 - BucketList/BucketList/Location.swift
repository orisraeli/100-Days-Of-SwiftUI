//
//  Location.swift
//  BucketList
//
//  Created by Or Israeli on 12/05/2023.
//

import CoreLocation
import Foundation

struct Location: Identifiable, Codable, Equatable {
	var id: UUID
	var name: String
	var description: String
	let latitude: Double
	let longitude: Double
	
	var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	static let example = Location(id: UUID(), name: "Barcelona", description: "Barcelona is a city on the coast of northeastern Spain. It is the capital and largest city of the autonomous community of Catalonia, as well as the second most populous municipality of Spain. With a population of 1.6 million within city limits,[7] its urban area extends to numerous neighbouring municipalities within the Province of Barcelona and is home to around 4.8 million people,[3] making it the fifth most populous urban area in the European Union after Paris, the Ruhr area, Madrid, and Milan.[3] It is one of the largest metropolises on the Mediterranean Sea, located on the coast between the mouths of the rivers Llobregat and Besòs, and bounded to the west by the Serra de Collserola mountain range.", latitude: 41.3874, longitude: 2.1686)
	
	static func ==(lhs: Location, rhs: Location) -> Bool {
		lhs.id == rhs.id
	}
}
