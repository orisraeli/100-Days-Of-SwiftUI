//
//  DataController.swift
//  FriendsList
//
//  Created by Or Israeli on 05/05/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
	let container = NSPersistentContainer(name: "FriendsList")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Failed to load data model: \(error.localizedDescription)")
				return
			} else {
				print("Data model loaded successfully.")
				self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
			}
		}
	}
}
