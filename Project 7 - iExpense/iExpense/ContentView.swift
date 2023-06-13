//
//  ContentView.swift
//  iExpense
//
//  Created by Or Israeli on 15/04/2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject var expenses = Expenses()
	
	@State private var showingAddExpense = false

	var body: some View {
		NavigationStack {
			List {
				Section("Personal") {
					ForEach(expenses.items) { item in
						//Day 38 - Challenge 3
						if item.type == "Personal" {
							HStack {
								VStack(alignment: .leading) {
									Text(item.name)
										.font(.headline)
										.padding(.bottom, 2)
									Text(item.formattedCreatedDate)
										.font(.subheadline)
								}
								
								Spacer()
								
								Text(item.formattedAmount)
									.foregroundColor(amountColor(amount: item.amount))
							}
							//Day 76 - Challenge 2
							.accessibilityElement()
							.accessibilityLabel("\(item.name), cost \(item.formattedAmount)")
							.accessibilityHint("Personal, Created on \(item.formattedCreatedDate)")
						}
					}
					.onDelete(perform: removeItems)
				}
				
				Section("Business") {
					ForEach(expenses.items) { item in
						//Day 38 - Challenge 3
						if item.type == "Business" {
							HStack {
								VStack(alignment: .leading) {
									Text(item.name)
										.font(.headline)
										.padding(.bottom, 2)
									Text(item.formattedCreatedDate)
										.font(.subheadline)
								}
								
								Spacer()
								
								Text(item.formattedAmount)
									.foregroundColor(amountColor(amount: item.amount))
							}
							//Day 76 - Challenge 2
							.accessibilityElement()
							.accessibilityLabel("\(item.name), cost \(item.formattedAmount)")
							.accessibilityHint("Business, Created on \(item.formattedCreatedDate)")
						}
					}
					.onDelete(perform: removeItems)
				}
			}
			.navigationTitle("iExpense")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button {
						showingAddExpense = true
					} label: {
						Image(systemName: "plus")
					}
				}
			}
			.sheet(isPresented: $showingAddExpense) {
				AddView(expenses: expenses)
			}
		}
    }
	
	func removeItems(at offsets: IndexSet) {
		expenses.items.remove(atOffsets: offsets)
	}
	
	//Day 38 - Challenge 2
	func amountColor(amount: Double) -> Color {
		switch amount {
			case ..<10:
				return .green
			case 10..<100:
				return .orange
			case 100...:
				return .red
			default:
				return .primary
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
