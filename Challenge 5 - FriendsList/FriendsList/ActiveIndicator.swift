//
//  ActiveIndicator.swift
//  FriendsList
//
//  Created by Or Israeli on 04/05/2023.
//

import SwiftUI

struct ActiveIndicator: View {
	@State var isActive: Bool
	
    var body: some View {
		Circle()
			.fill(isActive ? .green : .gray)
//			.shadow(radius: 1)
			.frame(width: 10, height: 10)
			.overlay {
				Circle()
					.stroke(lineWidth: 0.2)
			}
    }
}

struct ActiveIndicator_Previews: PreviewProvider {
    static var previews: some View {
		ActiveIndicator(isActive: Bool.random())
    }
}
