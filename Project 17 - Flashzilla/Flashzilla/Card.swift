//
//  Card.swift
//  Flashzilla
//
//  Created by Or Israeli on 31/05/2023.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
	var id = UUID()
	let prompt: String
	let answer: String
	var isUserCorrect: Bool = false
	
	static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
	static let savePath = FileManager.documentsDirectoryURL.appendingPathComponent("Cards")
}
