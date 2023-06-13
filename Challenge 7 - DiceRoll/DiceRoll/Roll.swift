//
//  Roll.swift
//  DiceRoll
//
//  Created by Or Israeli on 08/06/2023.
//

import Foundation

struct Roll: Identifiable, Codable, Equatable {
	var id = UUID()
	let sides: Int
	let num1: Int
	let num2: Int
	let dateCreated: Date
	
	static let sidesOptions = [4, 6, 8, 10, 12, 20, 100]
	
	init(sides: Int = 6) {
		self.sides = sides
		self.num1 = Int.random(in: 1...sides)
		self.num2 = Int.random(in: 1...sides)
		self.dateCreated = Date.now
	}
}

class Rolls: ObservableObject {
	@Published private(set) var history: [Roll]
	
	private let savedDataPath = FileManager.documentsDirectoryURL.appendingPathComponent("rolls_history")
	
	init() {
		do {
			let data = try Data(contentsOf: savedDataPath)
			let decoded = try JSONDecoder().decode([Roll].self, from: data)
			history = decoded
		} catch {
			print("Error loading data: \(error.localizedDescription)")
			history = []
		}
	}
	
	func saveData() {
		do {
			let data = try JSONEncoder().encode(history)
			try data.write(to: savedDataPath)
		} catch {
			print("Error saving data: \(error.localizedDescription)")
		}
	}
	
	func add(_ roll: Roll) {
		history.append(roll)
		saveData()
	}
	
	func remove(at offsets: IndexSet) {
		history.remove(atOffsets: offsets)
		saveData()
	}
	
	func remove(at index: Int) {
		history.remove(at: index)
		saveData()
	}
}
