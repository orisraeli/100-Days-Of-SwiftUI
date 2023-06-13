//
//  ContentView.swift
//  Challenge2RockPaperScissors
//
//  Created by Or Israeli on 25/03/2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var playerMove = 0
	@State private var playerShouldWin = Bool.random()
	@State private var score = 0
	@State private var pcMove = Int.random(in: 0...2)
	@State private var showingAlert = false
	@State private var showingScore = false
	@State private var isPlayerCorrect = false
	@State private var gameCounter = 1
	
	let moves = ["🪨", "📃", "✂️"]
	let winningMoves = ["📃", "✂️", "🪨"]
	let gameLength = 10
	
	
	
    var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.purple, .indigo, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
				.ignoresSafeArea()
			
			VStack {
				Text("Rock Paper Scissors")
					.font(.largeTitle.bold())
					.foregroundColor(.white)
				
				Spacer()
				
				Text("Try to")
					.font(.title2)
					.foregroundColor(.white)
				
				Text(playerShouldWin ? "Win": "Lose")
					.font(.largeTitle.bold())
					.foregroundColor(.white)
				
				
				Text(moves[pcMove])
					.font(.system(size: 120))
					.padding()
				
				HStack(spacing: 20) {
					ForEach(moves, id: \.self) { move in
						Button {
							playerMove = winningMoves.firstIndex(of: move) ?? 0
							checkAnswer()
							showingAlert = true
						} label: {
							Text(move)
								.font(.system(size: 90))
								.background(.ultraThinMaterial)
								.clipShape(RoundedRectangle(cornerRadius: 10))
						}
					}
				}
				.alert(isPlayerCorrect ? "Correct" : "Incorrect", isPresented: $showingAlert) {
					Button("OK", action: nextQuestion)
				}
				
				.alert("Game over", isPresented: $showingScore) {
					Button("New Game", action: newGame)
				} message: {
					Text("Final score: \(score)")
				}
				
				Spacer()
				
				Text("Score: \(score)")
					.foregroundColor(.white)
					.font(.headline)
				Text("Game: \(gameCounter)/\(gameLength)")
					.foregroundColor(.white)
					.font(.headline)
					.padding(.bottom)
			}
			
		}
    }
	
	func checkAnswer() {

		if playerShouldWin {
			if playerMove == pcMove {
				isPlayerCorrect = true
				score += 1
			} else  {
				isPlayerCorrect = false
				score -= 1
			}
		} else {
			if playerMove == pcMove || winningMoves[playerMove] == moves[pcMove] {
				isPlayerCorrect = false
				score -= 1
			} else {
				isPlayerCorrect = true
				score += 1
			}
		}
	}
	
	func nextQuestion() {
		if gameCounter >= 10 {
			showingScore = true
		}
		
		playerShouldWin.toggle()
		pcMove = Int.random(in: 0...2)
		gameCounter += 1
	}
	
	func newGame() {
		score = 0
		gameCounter = 0
		nextQuestion()
	}
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
