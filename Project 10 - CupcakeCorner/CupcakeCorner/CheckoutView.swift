//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Or Israeli on 26/04/2023.
//

import SwiftUI

struct CheckoutView: View {
	@ObservedObject var orders: Orders
	@State var order: Order
	
	@State private var confirmationMessage = ""
	@State private var showingConfirmation = false
	
	@State private var errorMessage = ""
	@State private var showingErrorMessage = false
	
    var body: some View {
		ScrollView {
			VStack {
				AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
					image
						.resizable()
						.scaledToFit()
				} placeholder: {
					ProgressView()
				}
				.frame(height: 233)
				
				//Day 76 - Challenge 1
				.accessibilityElement()
				
				Text("Your total cost is: \(order.cost, format: .currency(code: "USD"))")
					.font(.title)
				
				Button("Place Order") {
					Task {
						await placeOrder()
					}
				}
					.padding()
			}
		}
		.navigationTitle("Checkout")
		.navigationBarTitleDisplayMode(.inline)
		
		.alert("Thank you!", isPresented: $showingConfirmation) {
			Button("OK") { }
		} message: {
			Text(confirmationMessage)
		}
		
		.alert("Oops!", isPresented: $showingErrorMessage) {
			Button("OK") { }
		} message: {
			Text(errorMessage)
		}
    }
	
	func placeOrder() async {
		guard let encoded = try? JSONEncoder().encode(order) else {
			print("Failed to encode order")
			return
		}
		
		let url = URL(string: "https://reqres.in/api/cupcakes")!
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		
		do {
			let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
			
			let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
			confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
			showingConfirmation = true
		} catch {
			print("Checkout failed")
			errorMessage = "Couldn't place order. \nError: \(error.localizedDescription)"
			showingErrorMessage = true
		}
	}
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			CheckoutView(orders: Orders(), order: Order())
		}
    }
}
