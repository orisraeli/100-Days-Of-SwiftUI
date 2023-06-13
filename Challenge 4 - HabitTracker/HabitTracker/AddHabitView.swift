//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Or Israeli on 24/04/2023.
//

import SwiftUI

struct AddHabitView: View {
	@ObservedObject var habits: Habits
	@Environment(\.dismiss) var dismiss
	
	@State private var name = ""
	@State private var description = ""
	@State private var icon = ""
	
	
	var body: some View {
		NavigationStack {
			Form {
				Section("Details") {
					TextField("Name", text: $name)
						.foregroundColor(.accentColorHT)
					TextField("Description", text: $description)
					
				}
				
				
				Section("Icon") {
					TextField("Icon", text: $icon)
				}
			}
			.scrollContentBackground(.hidden)
			.background(.darkBackgroundHT)
			.preferredColorScheme(.dark)
			.navigationTitle("Add New Habit")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", role: .cancel) {
						dismiss()
					}
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button("Add") {
						if name.isEmpty {
							name = "New habit"
						}
						
						let item = Habit(name: name, description: description, icon: icon)
						habits.items.append(item)
						
						dismiss()
					}
				}
			}
			.tint(.accentColorHT)
		}
	}
}

struct AddHabitView_Previews: PreviewProvider {
	static var previews: some View {
		AddHabitView(habits: Habits())
	}
}
