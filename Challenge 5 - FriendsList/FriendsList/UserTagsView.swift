//
//  UserTagsView.swift
//  FriendsList
//
//  Created by Or Israeli on 04/05/2023.
//

import SwiftUI

struct UserTagsView: View {
	let tags: [String]
	
	var body: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 20) {
				ForEach(tags, id: \.self) { (tag: String) in
						Text(tag)
						.foregroundColor(.white)
						.padding()
						.background(
							Capsule()
								.foregroundColor(.blue)
								.frame(minWidth: 60, maxHeight: 30)
						)
				}
			}
			.frame(maxHeight: 35)
		}
		.scrollIndicators(.hidden)

	}
}

struct UserTagsView_Previews: PreviewProvider {
	static var previews: some View {
		UserTagsView(tags: ["excepteur",
							"et",
							"irure",
							"officia",
							"pariatur",
							"nostrud",
							"minim"])
	}
}
