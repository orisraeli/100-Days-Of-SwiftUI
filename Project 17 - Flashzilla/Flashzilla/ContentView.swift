//
//  ContentView.swift
//  Flashzilla
//
//  Created by Or Israeli on 29/05/2023.
//

import SwiftUI

extension View {
	func stacked(card: Card, in cards: [Card]) -> some View {
		if let position = cards.firstIndex(of: card) {
			let total = cards.count
			let offset = Double(total - position)
			
			return self.offset(y: offset * 10)
		}
		
		return self.offset(y: .zero)
	}
}

struct ContentView: View {
	@Environment(\.scenePhase) var scenePhase
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	@Environment(\.accessibilityVoiceOverEnabled) var voiceOver
	
	@State private var cards = [Card]()
	@State private var timeRemaining = 100
	@State private var isActive = true
	@State private var isShowingEditScreen = false
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	var body: some View {
		ZStack {
			Image(decorative: "background")
				.resizable()
				.ignoresSafeArea()
			
			VStack {
				Text("Time: \(timeRemaining)")
					.font(.largeTitle)
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.black.opacity(0.75))
					.clipShape(Capsule())
				
				ZStack {
					ForEach(cards) { card in
						CardView(card: card) { result in
							withAnimation {
								removeActiveCard(result: result)
							}
						}
						.stacked(card: card, in: cards)
						.allowsHitTesting(card == cards.last)
						.accessibilityHidden(card != cards.last)
					}
				}
				.allowsHitTesting(timeRemaining > 0)
				
				if cards.isEmpty {
					Button("Start Again", action: resetCards)
						.padding()
						.background(.white)
						.foregroundColor(.black)
						.clipShape(Capsule())
						.padding()
				}
			}
			
			VStack {
				HStack {
					Spacer()
					
					Button {
						isShowingEditScreen = true
					} label: {
						Image(systemName: "plus.circle")
							.padding()
							.background(.black.opacity(0.75))
							.clipShape(Circle())
					}
				}
				
				Spacer()
			}
			.foregroundColor(.white)
			.font(.largeTitle)
			.padding()
			
			if differentiateWithoutColor || voiceOver {
				VStack {
					Spacer()
					
					HStack {
						Button {
							withAnimation {
								removeActiveCard(result: false)
							}
						} label: {
							Image(systemName: "xmark.circle")
								.padding()
								.background(.black.opacity(0.7))
								.clipShape(Circle())
						}
						.accessibilityLabel("Wrong")
						.accessibilityHint("Mark your answer as being incorrect")
						
						Spacer()
						
						Button {
							withAnimation {
								removeActiveCard(result: true)
							}
						} label: {
							Image(systemName: "checkmark.circle")
								.padding()
								.background(.black.opacity(0.7))
								.clipShape(Circle())
						}
						.accessibilityLabel("Correct")
						.accessibilityHint("Mark your answer as being correct")
					}
					.foregroundColor(.white)
					.font(.largeTitle)
					.padding()
				}
			}
		}
		.onReceive(timer) { time in
			guard isActive else { return }
			
			if timeRemaining > 0 {
				timeRemaining -= 1
			}
		}
		.onChange(of: scenePhase) { phase in
			if phase == .active {
				if cards.isEmpty == false {
					isActive = true
				}
			} else {
				isActive = false
			}
		}
		.sheet(isPresented: $isShowingEditScreen, onDismiss: resetCards, content: EditCardsView.init)
		.onAppear(perform: resetCards)
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
	
	//Day 91 - Challenge 3
	func removeActiveCard(result: Bool) {
		guard var card = cards.last else { return }
		
		cards.removeLast()
		
		if !result {
			card.id = UUID()
			cards.insert(card, at: 0)
		}
		
		if cards.isEmpty {
			isActive = false
		}
	}
	
	func resetCards() {
		timeRemaining = 100
		isActive = true
		loadData()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
