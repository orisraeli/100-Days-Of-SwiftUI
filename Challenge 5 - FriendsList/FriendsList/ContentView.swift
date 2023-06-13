//
//  ContentView.swift
//  FriendsList
//
//  Created by Or Israeli on 04/05/2023.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(users) { user in
					NavigationLink {
						UserView(user: user)
					} label: {
						ActiveIndicator(isActive: user.isActive)
						Text(user.wrappedName)
					}
				}
			}
			.task { await loadData() }
			.navigationTitle("FriendsList")
		}
	}
	
	func loadData() async {
		let users = await DataManager().loadJson()

		await MainActor.run {
//			if moc.hasChanges {
				for user in users {
					let cachedUser = CachedUser(context: moc)

					cachedUser.id = user.id
					cachedUser.isActive = user.isActive
					cachedUser.name = user.name
					cachedUser.age = Int16(user.age)
					cachedUser.company = user.company
					cachedUser.email = user.email
					cachedUser.address = user.address
					cachedUser.about = user.about
					cachedUser.registered = user.registered
					cachedUser.tags = user.tags.joined(separator: ",")

					for friend in user.friends {
						print(friend.name, friend.id)
						let cachedFriend = CachedFriend(context: moc)
						cachedFriend.id = friend.id
						cachedFriend.name = friend.name
						cachedUser.addToFriend(cachedFriend)
					}
					try? moc.save()
				}
				print("Data loaded successfully.")
//			} else {
//				print("No data changed")
//			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
