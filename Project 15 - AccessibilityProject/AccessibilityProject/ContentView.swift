//
//  ContentView.swift
//  AccessibilityProject
//
//  Created by Or Israeli on 16/05/2023.
//

import SwiftUI

struct ContentView: View {
	let pictures = [
		"ales-krivec-15949",
		"galina-n-189483",
		"kevin-horstmann-141705",
		"nicolas-tissot-335096"
	]
	
	let labels = [
		"Tulips",
		"Frozen tree buds",
		"Sunflowers",
		"Fireworks",
	]
	
	@State private var selectedPicture = Int.random(in: 0...3)
	@State private var value = 10
	
    var body: some View {
		NavigationStack {
			VStack {
				Image(pictures[selectedPicture])
					.resizable()
					.scaledToFit()
					.onTapGesture {
						selectedPicture = Int.random(in: 0...3)
					}
					//Short description
					.accessibilityLabel(labels[selectedPicture])
					
					//longer description after a delay
					.accessibilityHint("A tappable image of \(labels[selectedPicture])")
				
					//Describes view traits
					.accessibilityAddTraits(.isButton)
				
				//Shouldn't be read by VoiceOver unless we add traits or actions.
				Image(decorative: "imageName")
					.padding()
				
				Text("This text shouldn't be read by VoiceOver at all")
					.padding()
					.accessibilityHidden(true)
				
				VStack {
					Text("Your score is: ")
					Text("1000")
						.font(.title)
				}
				//We can tell VoiceOver to combine views together or igonre them
				//so we can provide specific label.
				.accessibilityElement()
				.accessibilityLabel("Your score is 1000")
				
				VStack {
					Text("Value: \(value)")
					
					Button("Increment") {
						value += 1
					}
					
					Button("Decrement") {
						value -= 1
					}
				}
				.padding()
				.accessibilityElement()
				.accessibilityLabel("Value")
				.accessibilityValue(String(value))
				.accessibilityAdjustableAction { direction in
					switch direction {
						case .increment:
							value += 1
						case .decrement:
							value -= 1
						default:
							print("Not handled")
					}
				}
			}
			.navigationTitle("Accessibility")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
