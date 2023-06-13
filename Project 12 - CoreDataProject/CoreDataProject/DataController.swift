//
//  DataController.swift
//  CoreDataProject
//
//  Created by Or Israeli on 02/05/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
	let container = NSPersistentContainer(name: "CoreDataProject")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Failed to load CoreData container. \(error.localizedDescription)")
				return
			}
			
			self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
		}
	}
}
