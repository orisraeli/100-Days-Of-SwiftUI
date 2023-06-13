//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Or Israeli on 16/04/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
	var id = UUID()
	let name: String
	let type: String
	let amount: Double
	let timestampCreated: Date
	
	init(name: String, type: String, amount: Double) {
		self.id = UUID()
		self.name = name
		self.type = type
		self.amount = amount
		self.timestampCreated = Date.now
	}
	
	var formattedCreatedDate: String {
		timestampCreated.formatted(date: .long, time: .shortened)
	}
	
	var formattedAmount: String {
		amount.formatted(.currency(code: currencyCode))
	}
	
	//Day 38 - Challenge 1
	var currencyCode: String {
		Locale.current.currency?.identifier ?? "USD"
	}
}
