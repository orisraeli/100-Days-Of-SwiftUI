//
//  ContentView.swift
//  WeSplit
//
//  Created by Or Israeli on 16/03/2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 0
	@State private var tipPercentage = 10
	@FocusState private var amountIsFocused: Bool
	
	let tipPercentages = [10, 15, 20, 25, 0]
	
	var tipValue: Double {
		let tipSelection = Double(tipPercentage)
		return checkAmount / 100 * tipSelection
	}
	
	var grandTotal: Double {
		checkAmount + tipValue
	}
	
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let amountPerPerson = grandTotal / peopleCount
		
		return amountPerPerson
	}
	
	var currencyCode: String {
		Locale.current.currency?.identifier ?? "USD"
	}
	
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Amount", value: $checkAmount,
							  format: .currency(code: currencyCode))
					.keyboardType(.decimalPad)
					.focused($amountIsFocused)
					
					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<100) {
							Text("\($0) people")
						}
					}
				}
				
				Section {
//					Picker("Tip Percentage", selection: $tipPercentage) {
//						ForEach(tipPercentages, id: \.self) {
//							Text($0, format: .percent)
//						}
//					}
//					.pickerStyle(.segmented)
					
					//Challenge 3:
					Picker("Tip Percentage", selection: $tipPercentage) {
						ForEach(0..<101) {
							Text($0, format: .percent)
						}
					}
					
				} header: {
					Text("How much do you want to tip?")
				}
					
					
				
				Section {
					Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
				} header: {
					Text("Amount per person")
				}
				
				Section {
					Text(grandTotal, format: .currency(code: currencyCode))
					//Project 3 - Challenge 1
						.foregroundColor(tipPercentage == 0 ? .red : .primary)
				} header: {
					Text("Total")
				}
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
