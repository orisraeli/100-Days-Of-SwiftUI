//
//  MSDivider.swift
//  Moonshot
//
//  Created by Or Israeli on 20/04/2023.
//

import SwiftUI

struct MSDivider: View {
    var body: some View {
		Rectangle()
			.frame(height: 2)
			.foregroundColor(.lightBackground)
			.padding(.vertical)
    }
}

struct MSDivider_Previews: PreviewProvider {
    static var previews: some View {
        MSDivider()
    }
}
