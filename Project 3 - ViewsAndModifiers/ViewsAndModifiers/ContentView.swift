//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Or Israeli on 22/03/2023.
//

import SwiftUI

struct BlueTitle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.font(.largeTitle.bold())
			.foregroundColor(.blue)
	}
}

extension View {
	func blueTitleStyle() -> some View {
		modifier(BlueTitle())
	}
}


struct ContentView: View {
	
    var body: some View {
		Text("Karin is fart")
			.blueTitleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
