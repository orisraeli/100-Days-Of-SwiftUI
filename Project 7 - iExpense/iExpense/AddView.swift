//
//  AddView.swift
//  iExpense
//
//  Created by Or Israeli on 16/04/2023.
//

import SwiftUI

struct AddView: View {
	
	@ObservedObject var expenses: Expenses
	@Environment(\.dismiss) var dismiss
	
	@State private var name = ""
	@State private var type = "Personal"
	@State private var amount = 0.0
	
	let types = ["Personal", "Business"]
	
    var body: some View {
		NavigationStack {
			Form {
				TextField("Name", text: $name)
				
				Picker("Type", selection: $type) {
					ForEach(types, id: \.self) {
						Text($0)
					}
				}
				
				TextField("Amount", value: $amount, format: .currency(code: "USD"))
					.keyboardType(.decimalPad)
			}
			.navigationTitle("Add new expense")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						dismiss()
					}
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						if name == "" {
							name = "New expanse"
						}
						
						let item = ExpenseItem(name: name, type: type, amount: amount)
						expenses.items.append(item)
						
						dismiss()
					}
				}
			}
		}
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
