//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Or Israeli on 26/04/2023.
//

import SwiftUI

struct AddressView: View {
	@ObservedObject var orders: Orders
	@State var order: Order
	
	var body: some View {
		Form {
			Section {
				TextField("Name", text: $order.name)
				TextField("Street Address", text: $order.streetAddress)
				TextField("City", text: $order.city)
				TextField("Zip", text: $order.zip)
			}
			
			Section {
				NavigationLink {
					CheckoutView(orders: orders, order: order)
				} label: {
					Text("Checkout")
				}
			}
			.disabled(order.hasValidAddress == false)
		}
		.navigationTitle("Delivery Details")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct AddressView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationStack {
			AddressView(orders: Orders(), order: Order())
		}
	}
}
