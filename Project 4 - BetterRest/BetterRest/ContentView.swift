//
//  ContentView.swift
//  BetterRest
//
//  Created by Or Israeli on 27/03/2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
	@State private var sleepAmount = 8.0
	@State private var wakeUp = defaultWakeTime
	@State private var coffeeAmount = 0
	
	static var defaultWakeTime: Date {
		var components = DateComponents()
		components.hour = 7
		components.minute = 0
		
		return Calendar.current.date(from: components) ?? Date.now
	}
	
	var body: some View {
		NavigationView {
			Form {
				//Challenge 1
				Section {
					HStack {
						Text("When do you want to wake up?")
							.font(.headline)
						
						Spacer()
						
						DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
							.labelsHidden()
					}
				} header: {
					Text("Wake up")
				}
				
				Section {
					Text("Desired amount of sleep")
						.font(.headline)
					
					Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
				} header: {
					Text("Sleep")
				}
				
				Section {
					Text("Daily coffee intake")
						.font(.headline)
					
					//Challenge 2
					Picker("Cups of coffee", selection: $coffeeAmount) {
						ForEach(1..<21) {
							Text($0 == 1 ? "1 cup" : "\($0) cups")
						}
					}
				} header: {
					Text("Coffee")
				}
				
				Section {
					//Challenge 3
					Text("Your ideal bedtime is \(calculateBedtime())")
						.font(.headline)
					
				} header: {
					Text("Bedtime")
				}
			}
			.navigationTitle("BetterRest")
		}
	}
	
	func calculateBedtime() -> String {
		print("wakeUp: \(wakeUp), sleepAmount: \(sleepAmount), coffeeAmount: \(coffeeAmount + 1)")
		do {
			let config = MLModelConfiguration()
			let model = try sleepCalulator(configuration: config)
			
			let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
			let hour = (components.hour ?? 0) * 60 * 60
			let minute = (components.minute ?? 0) * 60
			
			let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount) + 1)
			let sleepTime = wakeUp - prediction.actualSleep
			
			return sleepTime.formatted(date: .omitted, time: .shortened)
		} catch {
			return "Error"
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
