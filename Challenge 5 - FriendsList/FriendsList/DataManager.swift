//
//  DataManager.swift
//  FriendsList
//
//  Created by Or Israeli on 05/05/2023.
//

import Foundation

class DataManager {
	func loadJson() async -> [User] {
		let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
		
		var request = URLRequest(url: url)
		request.setValue("applications/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "GET"
		
		do {
			let (data, _) = try await URLSession.shared.data(for: request)
			
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			
			let decoded = try decoder.decode([User].self, from: data)
			
			//add data to users array
			print("Data downloaded successfully.")
			return decoded
		} catch {
			print("Couldnt download/decode data. \(error.localizedDescription)")
			return []
		}
	}
}
