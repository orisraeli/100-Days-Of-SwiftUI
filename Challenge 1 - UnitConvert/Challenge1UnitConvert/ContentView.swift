//
//  ContentView.swift
//  Challenge1UnitConvert
//
//  Created by Or Israeli on 18/03/2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var inputTemperatureUnit: String = "Celsius"
	@State private var outputTemperatureUnit: String = "Fahrenheit"
	@State private var temp: Double = 0
	@FocusState private var isTempSelected: Bool
	
	var convertedTemp: Double {
		var celsiusTemp: Double = 0
		switch inputTemperatureUnit {
			case "Celsius":
				celsiusTemp = temp
			case "Fahrenheit":
				celsiusTemp = (temp - 32) * 5/9
			case "Kelvin":
				celsiusTemp = temp - 273.15
			default:
				celsiusTemp = temp
		}
		
		switch outputTemperatureUnit {
			case "Celsius":
				return celsiusTemp
			case "Fahrenheit":
				return (celsiusTemp * 9/5) + 32
			case "Kelvin":
				return celsiusTemp + 273.15
			default:
				return celsiusTemp
		}
	}
	
	let units = ["Celsius", "Fahrenheit", "Kelvin"]
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Temperature", value: $temp, format: .number)
						.focused($isTempSelected)
						.keyboardType(.decimalPad)
				}
				
				Section {
					Picker("Select unit", selection: $inputTemperatureUnit) {
						ForEach(units, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(.segmented)
				} header: {
					Text("Input Temperature Unit")
				}
				
				Section {
					Picker("Select unit", selection: $outputTemperatureUnit) {
						ForEach(units, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(.segmented)
				} header: {
					Text("Input Temperature Unit")
				}
				
				Section {
					Text(convertedTemp.formatted())
				} header: {
					Text("Result")
				}
			}
			.navigationTitle("Unit Convert")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					Button("Done") {
						isTempSelected = false
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
