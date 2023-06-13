//
//  People.swift
//  FaceFinder
//
//  Created by Or Israeli on 19/05/2023.
//

import CoreLocation
import UIKit

struct Person: Codable, Identifiable, Comparable {
	enum CodingKeys: CodingKey {
		case id, name, image, latitude, longitude
	}
	
	var id = UUID()
	var name: String
	var image: UIImage?
	let latitude: Double
	let longitude: Double
	
	static let savePath = FileManager.documentsDirectoryURL.appendingPathComponent("SavedPeople")
	
	var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	static var exampleLocation: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: 31.0461, longitude: 34.8516)
	}
	
	init(name: String, location: CLLocationCoordinate2D) {
		self.id = UUID()
		self.name = name
		self.latitude = location.latitude
		self.longitude = location.longitude
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.id = try container.decode(UUID.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.latitude = try container.decode(Double.self, forKey: .latitude)
		self.longitude = try container.decode(Double.self, forKey: .longitude)
		
		let imageData = try container.decode(Data.self, forKey: .image)
		self.image = UIImage(data: imageData)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(latitude, forKey: .latitude)
		try container.encode(longitude, forKey: .longitude)
		
		let imageData = image?.jpegData(compressionQuality: 0.8)
		try container.encode(imageData, forKey: .image)
	}
	
	static func < (lhs: Person, rhs: Person) -> Bool {
		lhs.name < rhs.name
	}
	
//	static func == (lhs: Person, rhs: Person) -> Bool {
//		lhs.id == rhs.id
//	}
}

class People: ObservableObject {
	@Published private(set) var items: [Person]
	
	private let savedDataKey = "SavedData"
	
	init() {
		if let data = UserDefaults.standard.data(forKey: savedDataKey) {
			if let decoded = try? JSONDecoder().decode([Person].self, from: data) {
				items = decoded
				return
			}
		}
		
		items = []
	}
	
	private func save() {
		if let encoded = try? JSONEncoder().encode(items) {
			UserDefaults.standard.set(encoded, forKey: savedDataKey)
		}
	}
	
	func add(person: Person) {
		items.append(person)
		save()
	}
}
