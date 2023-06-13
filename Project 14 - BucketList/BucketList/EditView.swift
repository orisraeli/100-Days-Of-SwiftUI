//
//  EditView.swift
//  BucketList
//
//  Created by Or Israeli on 12/05/2023.
//

import SwiftUI

struct EditView: View {
	@Environment(\.dismiss) var dismiss
	
	var onSave: (Location) -> Void
	
	@StateObject private var viewModel: ViewModel

    var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Name", text: $viewModel.name)
					TextField("Description", text: $viewModel.description)
				}
				
				Section("Nearby...") {
					switch viewModel.loadingState {
						case .loading:
							Text("Loading...")
						case .loaded:
							ForEach(viewModel.pages, id: \.pageid) { page in
								Text(page.title)
									.font(.headline)
								+ Text(": ")
								+ Text(page.description)
									.italic()
							}
						case .failed:
							Text("Please try again later.")

					}
				}
			}
			.navigationTitle("Place details")
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						var editedLocation = viewModel.location
						editedLocation.id = UUID()
						editedLocation.name = viewModel.name
						editedLocation.description = viewModel.description
						
						onSave(editedLocation)
						dismiss()
					}
				}
				
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", role: .cancel) {
						dismiss()
					}
				}
			}
			.task {
				await viewModel.fetchNearbyPlaces()
			}
		}
    }
	
	init(location: Location, onSave: @escaping (Location) -> Void) {
		_viewModel = StateObject(wrappedValue: ViewModel(location: location))
		
		self.onSave = onSave
	}
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
		EditView(location: Location.example) { _ in }
    }
}
