//
//  ContentView.swift
//  HabitTracker
//
//  Created by Or Israeli on 24/04/2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject var habits = Habits()
	@State private var addSheetIsPresented = false
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(habits.items) { item in
					NavigationLink {
						HabitDetailView(habits: habits, currentHabit: item)
					} label: {
						HStack {
							Text(item.name)
								.font(.title3)
							
							Spacer()
							
							Text(item.icon)
								.font(.largeTitle)
								.padding()
						}
					}
				}
				.onDelete(perform: removeItems)
				.listRowSeparator(.hidden)
				.listRowBackground(
					RoundedRectangle(cornerRadius: 15)
						.foregroundColor(.lightBackgroundHT)
						.padding(6)
				)
				
			}

			.navigationTitle("Habit Tracker")
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button {
						addSheetIsPresented = true
					} label: {
						Image(systemName: "plus")
					}
				}
				
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()
				}
			}
			
			.sheet(isPresented: $addSheetIsPresented) {
				AddHabitView(habits: habits)
			}
			.tint(.accentColorHT)
			.foregroundColor(.accentColorHT)
			.background(.darkBackgroundHT)
			.listStyle(.plain)
			.preferredColorScheme(.dark)
		}
		
	}
	
	func removeItems(at offsets: IndexSet) {
		habits.items.remove(atOffsets: offsets)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
