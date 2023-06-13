//
//  Habit.swift
//  HabitTracker
//
//  Created by Or Israeli on 24/04/2023.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
	var id = UUID()
	var name: String
	var description: String
	var icon: String
	var count: Int = 0
	
	init(name: String, description: String, icon: String) {
		self.name = name
		self.description = description
		self.icon = icon
	}
}
