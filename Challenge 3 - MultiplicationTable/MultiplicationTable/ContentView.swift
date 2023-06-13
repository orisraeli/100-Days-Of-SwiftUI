//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Or Israeli on 11/04/2023.
//

import SwiftUI

struct Question {
	var a: Int
	var b: Int
	var text: String
	var answer: Int
	var userAnswer: Int?
	
	init(a: Int, b: Int) {
		self.a = a
		self.b = b
		self.answer = a * b
		self.text = "\(a) x \(b) = "
	}
}

struct ContentView: View {
	
	@State var questions = [Question]()
	@State private var questionsAmount = 10
	@State private var testUpTo = 12
	@State private var showingAlert = false
	@State private var score = 0
	@State private var questionsAnsweredCorrectly = 0
	
	@FocusState private var answerIsFocused: Bool

	let questionsOptions = [5, 10, 15]
	
    var body: some View {
		
		NavigationStack {
			VStack {
				Form {
					Stepper("Test up to \(testUpTo)", value: $testUpTo, in: 2...12)
						.onChange(of: testUpTo) { _ in
							askQuestions()
						}

					Picker("Test Length", selection: $questionsAmount) {
						ForEach(questionsOptions, id: \.self) {
							Text("\($0) questions")
						}
					}
					.onChange(of: questionsAmount) { _ in
						askQuestions()
					}
					
					Section("Questions") {
						List(0..<questions.count, id: \.self) { row in
							HStack {
								Image(systemName: "\(row + 1).circle")
								Text(questions[row].text)
									.fixedSize()
									.frame(width: 60)
								
								TextField("Answer", value: $questions[row].userAnswer, format: .number)
									.keyboardType(.numberPad)
									.focused($answerIsFocused)
								
							}
						}
					}
					
					Section {
						Button("Check Answers") {
							answerIsFocused = false
							showingAlert = true
							
							checkQuestions()
						}
					}
				}
			}
			
			.navigationTitle("Multi-Table")
			.onAppear(perform: askQuestions)
			.alert("Game Over", isPresented: $showingAlert) {
				Button("Ok") {
					askQuestions()
				}
			} message: {
				Text("You have answered \(questionsAnsweredCorrectly)/\(questionsAmount) questions correctly. Final score: \(score) out of \(10 * questionsAmount)  points.")
			}
		}
		.tint(.purple)
    }

	
	func askQuestions() {
		questions.removeAll()
		score = 0
		questionsAnsweredCorrectly = 0
		
		for _ in 0..<questionsAmount {
			questions.append(Question(a: Int.random(in: 1...testUpTo), b: Int.random(in: 1...testUpTo)))
		}
	}
	
	func checkQuestions() {
		for question in questions {
			if question.userAnswer == question.answer {
				score += 10
				questionsAnsweredCorrectly += 1
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
