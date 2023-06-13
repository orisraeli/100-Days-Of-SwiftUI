//
//  FriendsListApp.swift
//  FriendsList
//
//  Created by Or Israeli on 04/05/2023.
//

import SwiftUI

@main
struct FriendsListApp: App {
	@StateObject private var dataController = DataController()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
