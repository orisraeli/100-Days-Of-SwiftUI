//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Or Israeli on 20/03/2023.
//

import SwiftUI

struct FlagImage: View {
	let imageName: String
	
	var body: some View {
		Image(imageName)
			.renderingMode(.original)
//			.clipShape(Capsule(()
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.shadow(radius: 5)
	}
}

struct ContentView: View {
	
	@State private var score = 0 {
		didSet {
			if score < 0 {
				score = 0
			}
		}
	}
	
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	@State private var questionsCounter = 1
	@State private var chosenAnswer = 0
	@State private var showingGameOverAlert = false
	@State private var animationAmountRotate = 0.0
	@State private var animationAmountOpacity = 1.0
	@State private var animationAmountScale = 1.0
	
	let gameLength = 8
	let labels = [
		"Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
		"France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
		"Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
		"Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
		"Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
		"Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
		"Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
		"Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
		"Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
		"UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
		"US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
	]
	
	var body: some View {
		ZStack {
			RadialGradient(stops: [
				.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
				.init(color: Color(red: 0.75, green: 0.15, blue: 0.26), location: 0.3)
			], center: .top, startRadius: 200, endRadius: 700)
				.ignoresSafeArea()
			
			VStack {
				Spacer()
				Text("Guess the Flag")
					.font(.largeTitle.bold())
					.foregroundColor(.white)
				
				VStack(spacing: 15) {
					VStack {
						Text("Tap the flag of")
							.font(.headline.weight(.heavy))
						Text(countries[correctAnswer])
							.foregroundStyle(.secondary)
							.font(.largeTitle.weight(.semibold))
					}
					
					ForEach(0..<3) { number in
						Button {
							flagTapped(number)
						} label: {
							FlagImage(imageName: countries[number])
								.rotation3DEffect(.degrees(number == chosenAnswer ? animationAmountRotate : 0), axis: (x: 0, y: 1, z: 0))
								.opacity(number != chosenAnswer ? animationAmountOpacity : 1)
								.scaleEffect(number != chosenAnswer ? animationAmountScale : 1)
							
								//Day 75 - Fixing Accessibility issues
								.accessibilityLabel(labels[countries[number], default: "Unknown Flag"])
						}
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.regularMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				
				Spacer()
				Spacer()
				
				Text("Score: \(score)")
					.foregroundColor(.white)
					.font(.title.bold())
					.padding(.bottom, 2)
				
				Text("Question: \(questionsCounter)/\(gameLength)")
					.foregroundColor(.white)
					.font(.title2.bold())
				
				Spacer()
			}
			.padding()
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			if questionsCounter >= gameLength {
				Text("Game Over.\nFinal score: \(score).")
			}
			
			//Challenge 2
			if scoreTitle == "Correct!" {
				Text("Your score is \(score).")
			} else {
				Text("That's the flag of \(countries[chosenAnswer]).")
			}
		}
	}
	
	func flagTapped(_ number: Int) {
		chosenAnswer = number
		withAnimation {
			animationAmountRotate += 360
			animationAmountOpacity = 0.25
			animationAmountScale = 0.8
		}
		
		if number == correctAnswer {
			scoreTitle = "Correct!"
			//Challenge 1
			score += 50
		} else {
			scoreTitle = "Wrong!"
			score -= 30
		}
		
		showingScore = true
	}
	
	func askQuestion() {
		//Challenge 3
		if questionsCounter >= gameLength {
			score = 0
			questionsCounter = 0
		}
		
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
		questionsCounter += 1
		animationAmountOpacity = 1
		animationAmountScale = 1
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
