//
//  User.swift
//  FriendsList
//
//  Created by Or Israeli on 04/05/2023.
//

import Foundation

struct User: Codable, Identifiable {
	let id: String
	let isActive: Bool
	let name: String
	let age: Int
	let company: String
	let email: String
	let address: String
	let about: String
	let registered: Date
	let tags: [String]
	let friends: [Friend]
	
	var formattedRegisteredDate: String {
		registered.formatted(date: .abbreviated, time: .omitted)
	}
	
	static var exampleUser = User(id: "kajbdkjsnbak",
								   isActive: true,
								   name: "Mikey Israeli",
								   age: 8,
								   company: "Mikey Dining Services TM",
								   email: "mikey@dog.com",
								   address: "Rotchild 70, Tel-Aviv, Israel",
								   about: "I'm a fat little dog from a fat family.",
								  registered: Date.now,
								   tags: ["Dog", "Fat"],
								   friends: [Friend(id: "123456", name: "Or Israeli"),
											Friend(id: "654321", name: "Karin Israeli")])

}
