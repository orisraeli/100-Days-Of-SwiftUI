//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Or Israeli on 26/04/2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject var orders = Orders()
	@State private var order = Order()
	
    var body: some View {
		NavigationStack {
			Form {
				Section {
					Picker("Select your cake type", selection: $order.type) {
						ForEach(Order.types.indices, id: \.self) {
							Text(Order.types[$0])
						}
					}

					Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
				}
				
				Section {
					Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())

					if order.specialRequestEnabled {
						Toggle("Add extra frosting", isOn: $order.extraFrosting)
						Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
					}
				}
				
				Section {
					NavigationLink {
						AddressView(orders: orders, order: order)
					} label: {
						Text("Delivery Details")
					}
				}
			}
			.navigationTitle("Cupcake Corner")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
