//
//  ContentView.swift
//  DiceRoll
//
//  Created by Or Israeli on 08/06/2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject var rolls = Rolls()
	@State private var roll: Roll?
	@State private var sides = 6
	@State private var feedback = UINotificationFeedbackGenerator()

	let sidesOptions = Roll.sidesOptions
	
    var body: some View {
		VStack {
			Picker("Sides", selection: $sides) {
				ForEach(sidesOptions, id: \.self) { number in
					Text(String(number))
				}
			}
			.pickerStyle(.segmented)
			.padding()
			
			DiceView(roll: roll)
			
			Spacer(minLength: 20)
			
			Button {
				feedback.notificationOccurred(.success)
				roll = Roll(sides: sides)
				rolls.add(roll!)
			} label: {
				Label("Roll", systemImage: "dice.fill")
					.font(.title)
					.foregroundColor(.white)
					.padding()
					.background(.blue)
					.clipShape(Capsule())
			}
			
			Spacer()
			
			Form {
				List {
					Section("History") {
						ForEach(rolls.history.reversed()) { roll in
							HStack {
								Text("\(roll.num1), \(roll.num2)")
								
								Spacer()
								
								Text(roll.dateCreated.formatted(date: .abbreviated, time: .shortened))
							}
						}
						.onDelete(perform: handleReversedArray)
					}
				}
			}
		}
		.onAppear {
			feedback.prepare()
		}
    }
	
	func handleReversedArray(of index: IndexSet) {
		let item = rolls.history.reversed()[index.first!]
		if let ndx = rolls.history.firstIndex(of: item) {
			rolls.remove(at: ndx)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
