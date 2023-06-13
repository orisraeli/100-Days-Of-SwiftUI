//
//  Mission.swift
//  Moonshot
//
//  Created by Or Israeli on 19/04/2023.
//

import Foundation

struct Mission: Codable, Identifiable {
	struct CrewRole: Codable {
		let name: String
		let role: String
	}
	
	let id: Int
	let launchDate: Date?
	let crew: [CrewRole]
	let description: String
	
	var displayName: String {
		"Apollo \(id)"
	}
	
	var image: String {
		"apollo\(id)"
	}
	
	var formattedLaunchDate: String {
		launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
	}
	
	var formattedLongLaunchDate: String {
		launchDate?.formatted(date: .long, time: .omitted) ?? "N/A"
	}
}
