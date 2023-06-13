//
//  ContentView.swift
//  WordScramble
//
//  Created by Or Israeli on 29/03/2023.
//

import SwiftUI

struct ContentView: View {
	@State private var usedWords = [String]()
	@State private var rootWord = ""
	@State private var newWord = ""
	@State private var score = 0
	
	@State private var errorTitle = ""
	@State private var errorMessage = ""
	@State private var showingError = false
	
	var body: some View {
		NavigationStack {
			List {
				Section {
					TextField("Enter your word", text: $newWord)
						.textInputAutocapitalization(.never)
						.onSubmit(addNewWord)
						.alert(errorTitle, isPresented: $showingError) {
							Button("Ok", role: .cancel) { }
						} message: {
							Text(errorMessage)
						}
				}
				
				Section() {
					ForEach(usedWords, id: \.self) { word in
						HStack {
							Image(systemName: "\(word.count).circle")
							Text(word)
						}
						//Day 75 - Fixing Accessibility issues
						.accessibilityElement()
						.accessibilityLabel(word)
						.accessibilityHint("\(word.count) letters")
					}
				}
				
				
			}
			.navigationTitle(rootWord)
			.navigationBarTitleDisplayMode(.large)
			.onAppear(perform: startGame)
			.toolbar {
				//Challenge 2
				ToolbarItem(placement: .navigationBarTrailing) {
					Button("New Game", action: startGame)
				}
				ToolbarItem(placement: .navigationBarLeading) {
					Text("Score: \(score)")
				}

			}
		}
	}
	
	func addNewWord(){
		let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
		
		//Challenge 1
		guard answer != rootWord else {
			showWordError(title: "That's the root word", message: "You can't use the word you are given!")
			return
		}
		
		guard answer.count >= 3 else {
			showWordError(title: "Word too short", message: "Try finding a longer word!")
			return
		}
		
		guard isOriginal(answer) else {
			showWordError(title: "Word used already", message: "Be more original!")
			return
		}
		
		guard isPossible(answer) else {
			showWordError(title: "Word not possible", message: "You cant spell this word from '\(rootWord)'!")
			return
		}
		
		guard isRealWord(answer) else {
			showWordError(title: "Word not recognized", message: "You can't just make them up, you know!")
			return
		}
		
		withAnimation {
			usedWords.insert(answer, at: 0)
		}
	
		//Challenge 3
		if answer.count >= 6 {
			score += 2 * answer.count
		} else {
			score += 1 * answer.count
		}
		
		newWord = ""
	}
	
	func startGame() {
		if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let startWords = try? String(contentsOf: fileURL) {
				let allWords = startWords.components(separatedBy: "\n")
				rootWord = allWords.randomElement() ?? "silkworm"
				usedWords.removeAll()
				score = 0
				newWord = ""
				
				return
			}
		}
		
		fatalError("Could not load start.txt from bunble.")
	}
	
	func isOriginal(_ word: String) -> Bool {
		!usedWords.contains(word)
	}
	
	func isPossible(_ word: String) -> Bool {
		var tempWord = rootWord
		
		for letter in word {
			if let pos = tempWord.firstIndex(of: letter) {
				tempWord.remove(at: pos)
			} else {
				return false
			}
		}
		
		return true
	}
	
	func isRealWord(_ word: String) -> Bool {
		let checker = UITextChecker()
		let range = NSRange(location: 0, length: word.utf16.count)
		
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		
		return misspelledRange.location == NSNotFound
	}
	
	func showWordError(title: String, message: String) {
		errorTitle = title
		errorMessage = message
		showingError = true
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
