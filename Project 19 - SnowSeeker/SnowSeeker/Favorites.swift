//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Or Israeli on 12/06/2023.
//

import SwiftUI

class Favorites: ObservableObject {
	private var resorts: Set<String>
	private let saveKey = "favorites"
	
	init() {
		//Day 99 - Challenge 2
		if let data = UserDefaults.standard.data(forKey: saveKey) {
			if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
				resorts = decoded
				return

			}
		}
		
		//couldn't find data
		resorts = []
	}
	
	func contains(_ resort: Resort) -> Bool {
		resorts.contains(resort.id)
	}
	
	func add(_ resort: Resort) {
		objectWillChange.send()
		resorts.insert(resort.id)
		save()
	}
	
	func remove(_ resort: Resort) {
		objectWillChange.send()
		resorts.remove(resort.id)
		save()
	}
	
	func save() {
		//Day 99 - Challenge 2
		if let encoded = try? JSONEncoder().encode(resorts) {
			UserDefaults.standard.set(encoded, forKey: saveKey)
		}
	}
	
	
}
