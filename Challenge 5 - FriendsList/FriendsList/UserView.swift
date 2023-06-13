//
//  UserView.swift
//  FriendsList
//
//  Created by Or Israeli on 04/05/2023.
//

import SwiftUI

struct UserView: View {
	let user: CachedUser

    var body: some View {
		Form {
			Section("About") {
				Text(user.wrappedAbout)
			}
			
			Section("Personal Details") {
				UserRowView(title: "Age", data: String(user.age))
				UserRowView(title: "Email", data: user.wrappedEmail)
				UserRowView(title: "Company", data: user.wrappedCompany)
				UserRowView(title: "Address", data: user.wrappedAddress)
				UserRowView(title: "Joined", data: user.formattedDate)
			}
			
			Section("Friends") {
				ForEach(user.friendsArray) { friend in
					Text(friend.wrappedName)
				}
			}
			
			Section("Tags") {
				UserTagsView(tags: user.tagsArray)
					.listRowBackground(Color(uiColor: .systemGroupedBackground))
					.listRowInsets(EdgeInsets())
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationTitle(user.wrappedName)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			UserView(user: CachedUser())
		}
    }
}
