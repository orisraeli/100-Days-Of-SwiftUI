//
//  ContentView.swift
//  Drawing
//
//  Created by Or Israeli on 22/04/2023.
//

import SwiftUI

//Day 46 - Challenge 1
struct Arrow: Shape {
	var offset: Double = 0.3
	
	func path(in rect: CGRect) -> Path {
		let xOffset: Double = rect.width * offset
		let yOffset: Double = rect.height * offset
		
		var line = Path()
		line.move(to: CGPoint(x: rect.midX, y: rect.maxY))
		line.addLine(to: CGPoint(x: rect.midX, y: rect.minY + yOffset))
		
		var triangle = Path()
		triangle.move(to: CGPoint(x: rect.midX, y: rect.minY + yOffset))
		triangle.addLine(to: CGPoint(x: rect.minX + xOffset, y: rect.minY + yOffset))
		triangle.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		triangle.addLine(to: CGPoint(x: rect.maxX - xOffset, y: rect.minY + yOffset))
		triangle.addLine(to: CGPoint(x: rect.midX, y: rect.minY + yOffset))
		triangle.closeSubpath()
		
		triangle.addPath(line)
		return triangle
	}
}


//Day 46 - Challenge 3
struct ColorCyclingRectangle: View {
	var amount = 0.0
	var steps = 100
	var random1 = 1.0
	var random2 = 1.0
	var random3 = 1.0
	var random4 = 1.0
	
	var body: some View {
		ZStack {
			ForEach(0..<steps, id: \.self) { value in
				Rectangle()
					.inset(by: Double(value))
					.strokeBorder(
						LinearGradient(
							gradient: Gradient(colors: [
								color(for: value, brightness: 1),
								color(for: value, brightness: 0.5)
							]),
							startPoint: UnitPoint(x: random1, y: random2),
							endPoint: UnitPoint(x: random3, y: random4)
						),
						lineWidth: 2
					)
			}
		}
		.drawingGroup()
	}
	
	func color(for value: Int, brightness: Double) -> Color {
		var targetHue = Double(value) / Double(steps) + amount
		
		if targetHue > 1 {
			targetHue -= 1
		}
		
		return Color(hue: targetHue, saturation: 1, brightness: brightness)
	}
}


struct ContentView: View {
	//Arrow
	@State private var lineWidth = 10.0
	
	//Color Cycling Rect
	@State private var random1 = 0.0
	@State private var random2 = 0.0
	@State private var random3 = 0.0
	@State private var random4 = 0.0
	@State private var colorCycle = 0.0
	
	
	var body: some View {
		VStack {
			ZStack {
				Arrow()
					.rotation(Angle(degrees: -33))
					.fill()
					.frame(width: 300, height: 300)
				
				Arrow()
					.stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
					.rotation(Angle(degrees: -33))
					.frame(width: 300, height: 300)
					.padding()
					.onTapGesture {
						//Day 46 - Challenge 2
						withAnimation {
							lineWidth = Double.random(in: 1...100)
						}
					}
			}
			
			Spacer()
			
			ColorCyclingRectangle(amount: colorCycle,
								  random1: random1,
								  random2: random2,
								  random3: random3,
								  random4: random4)
				.frame(width: 300, height: 300)
				.onTapGesture {
					random1 = Double.random(in: 0...1)
					random2 = Double.random(in: 0...1)
					random3 = Double.random(in: 0...1)
					random4 = Double.random(in: 0...1)
				}
			
			Slider(value: $colorCycle)
				.padding()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
