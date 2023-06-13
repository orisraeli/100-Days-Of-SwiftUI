//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Or Israeli on 24/04/2023.
//

import SwiftUI

struct HabitDetailView: View {
	@ObservedObject var habits: Habits
	
	var currentHabit: Habit

	var body: some View {
		ZStack(alignment: .topLeading) {
			Color.darkBackgroundHT
				.ignoresSafeArea()
			VStack {
				VStack(alignment: .leading) {
					
					HStack {
						Text(currentHabit.description)
							.font(.system(size: 22))
							.padding()
						
						Text(currentHabit.icon)
							.font(.system(size: 72))
							.padding()
					}

				}
				
				Spacer()
				
				HStack {
					Spacer()
					
					VStack {
						Text("Completed: \(currentHabit.count)")
							.font(.system(size: 22))
						
						Button {
							var updatedHabbit = currentHabit
							
							updatedHabbit.count += 1
							
							if let habitIndex = habits.items.firstIndex(of: currentHabit) {
								habits.items[habitIndex] = updatedHabbit
								
							}
						} label: {
							Text("Add Record")
								.foregroundColor(.darkBackgroundHT)
								.font(.title2)
						}
						.buttonStyle(.borderedProminent)
						.padding(.horizontal)
					}
					
					Spacer()
				}
			}
			
				.navigationTitle(currentHabit.name)
				.preferredColorScheme(.dark)
				.tint(.accentColorHT)
		}
	}
}

struct HabitDetailView_Previews: PreviewProvider {
	static let habit = Habit(name: "Drink water",
							 description: "I should drink more water",
							 icon: "💧")
	
	static var previews: some View {
		HabitDetailView(habits: Habits(), currentHabit: habit)
	}
}
