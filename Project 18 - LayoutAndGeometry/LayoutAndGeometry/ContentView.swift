//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Or Israeli on 04/06/2023.
//

import SwiftUI

struct ContentView: View {
	let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
	
	var body: some View {
		GeometryReader { fullViewProxy in
			ScrollView(.vertical) {
				ForEach(0..<200) { index in
					GeometryReader { cellProxy in
						Text("Row #\(index)")
							.font(.title)
							.frame(maxWidth: .infinity)
//							.background(colors[index % 7])
							//Day 94 - Challenge 3
							.background(Color(hue: .minimum(1.0,(cellProxy.frame(in: .global).minY - fullViewProxy.size.height / 2)),saturation: 0.6,brightness: 0.8))
							.rotation3DEffect(.degrees(cellProxy.frame(in: .global).minY - fullViewProxy.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
							//Day 94 - Challenge 1
							.opacity((cellProxy.frame(in: .global).minY / 300) - 0.15)
							//Day 94 - Challenge 2
							.scaleEffect(.maximum((cellProxy.frame(in: .global).maxY / 900) * 2, 0.5))
					}
					.frame(height: 40)
				}
			}
		}
		
	}
	
	func showStats() {

	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
