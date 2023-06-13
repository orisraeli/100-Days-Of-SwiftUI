//
//  EditCardsView.swift
//  Flashzilla
//
//  Created by Or Israeli on 02/06/2023.
//

import SwiftUI

struct EditCardsView: View {
	@Environment(\.dismiss) var dismiss
	
	@State private var cards = [Card]()
	@State private var newPrompt = ""
	@State private var newAnswer = ""
	
    var body: some View {
		NavigationStack {
			List {
				Section("Add new card") {
					TextField("Prompt", text: $newPrompt)
					TextField("Answer", text: $newAnswer)
					Button("Add Card", action: addCard)
				}
				
				Section {
					ForEach(cards, id: \.prompt) { card in
						VStack {
							Text(card.prompt)
								.font(.headline)
							Text(card.answer)
								.foregroundColor(.secondary)
						}
					}
					.onDelete(perform: deleteCards)
				}
			}
			.navigationTitle("Edit Cards")
			.toolbar {
				Button("Done", action: done)
			}
			.listStyle(.grouped)
			.onAppear(perform: loadData)
		}
    }
	
	func loadData() {
		do {
			let data = try Data(contentsOf: Card.savePath)
			let decoded = try JSONDecoder().decode([Card].self, from: data)
			cards = decoded
		} catch {
			print("Error loading data: \(error.localizedDescription)")
			cards = []
		}
	}
	
	func saveData() {
		//Day 91 - Challenge 4
		do {
			let data = try JSONEncoder().encode(cards)
			try data.write(to: Card.savePath)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func done() {
		dismiss()
	}
	
	func addCard() {
		let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
		let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
		guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
		
		let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
		cards.insert(card, at: 0)
		
		saveData()
		
		//Day 91 - Challenge 1
		newPrompt = ""
		newAnswer = ""
	}
	
	func deleteCards(at offsets: IndexSet) {
		cards.remove(atOffsets: offsets)
		saveData()
	}
}

struct EditCardsView_Previews: PreviewProvider {
    static var previews: some View {
		EditCardsView()
    }
}
