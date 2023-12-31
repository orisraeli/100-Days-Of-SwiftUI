//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Or Israeli on 02/05/2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
	@StateObject private var dataController = DataController()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
