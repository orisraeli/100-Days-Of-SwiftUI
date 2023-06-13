//
//  UserRowView.swift
//  FriendsList
//
//  Created by Or Israeli on 04/05/2023.
//

import SwiftUI

struct UserRowView: View {
	var title: String
	var data: String
	
	var body: some View {
		HStack(alignment: .firstTextBaseline) {
			Text(title)
				.bold()
			Spacer()
			Text(data)
				.multilineTextAlignment(.trailing)
		}
	}
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(title: "Title", data: "Data")
			.padding()
    }
}
