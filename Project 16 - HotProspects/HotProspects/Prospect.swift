//
//  Prospect.swift
//  HotProspects
//
//  Created by Or Israeli on 25/05/2023.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
	var id = UUID()
	var name = "Anonymous"
	var emailAddress = ""
	var dateCreated: Date?
	fileprivate(set) var isContacted = false
	
	static func < (lhs: Prospect, rhs: Prospect) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: Prospect, rhs: Prospect) -> Bool {
		lhs.id == rhs.id
	}
}

@MainActor class Prospects: ObservableObject {
	@Published private(set) var people: [Prospect]
	
	private let savedDataKey = "SavedData"
	private let savedDataDir = FileManager.documentsDirectoryURL.appendingPathComponent("SavedData")
	
	init() {
		//Day 85 - Challenge 2
		do {
			let data = try Data(contentsOf: savedDataDir)
			let decoded = try JSONDecoder().decode([Prospect].self, from: data)
			people = decoded
		} catch {
			print("Error loading data: \(error.localizedDescription)")
			people = []
		}
	}
	
	private func save() {
		do {
			let encoded = try JSONEncoder().encode(people)
			try encoded.write(to: savedDataDir)
		} catch {
			print("Error saving data: \(error.localizedDescription)")
		}
	}
	
	func add(_ prospect: Prospect) {
		people.append(prospect)
		save()
	}
	
	func toggleIsContacted(for prospect: Prospect) {
		objectWillChange.send()
		prospect.isContacted.toggle()
		save()
	}
	
	func sortByName() {
		people = people.sorted()
	}
	
	func sortByDate() {
		people = people.sorted {
			if let lhsDate = $0.dateCreated, let rhsDate = $1.dateCreated {
				return 	lhsDate > rhsDate
			}
			
			return false
		}
	}
}
