//
//  Habbits.swift
//  HabitTracker
//
//  Created by Or Israeli on 24/04/2023.
//

import Foundation

class Habits: ObservableObject {
	@Published var items = [Habit]() {
		didSet {
			if let encoded = try? JSONEncoder().encode(items) {
				UserDefaults.standard.set(encoded, forKey: "habits")
			}
		}
	}
	
	init() {
		if let savedItems = UserDefaults.standard.data(forKey: "habits") {
			if let decoded = try? JSONDecoder().decode([Habit].self, from: savedItems) {
				items = decoded
				return
			}
		}
		
		items = []
	}
	
	static let exampleItems = [
		Habit(name: "Drink water", description: "I should drink more water", icon: "💧"),
		Habit(name: "Practice guitar", description: "Play atleast 1 hour a day!", icon: "🎸"),
		Habit(name: "Go for a run", description: "Probably should lose some weight...", icon: "🏃‍♂️")
	]
}
