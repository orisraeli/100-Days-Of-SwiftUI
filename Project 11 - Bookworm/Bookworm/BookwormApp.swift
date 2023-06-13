//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Or Israeli on 28/04/2023.
//

import SwiftUI

@main
struct BookwormApp: App {
	@StateObject private var dataController = DataController()
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
		}
	}
}

