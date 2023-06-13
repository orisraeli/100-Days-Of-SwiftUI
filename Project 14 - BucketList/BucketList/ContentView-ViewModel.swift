//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Or Israeli on 14/05/2023.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
	@MainActor class ViewModel: ObservableObject {
		enum UnlockError {
			case failed(Bool)
			case noBiometrics(Bool)
		}
		
		@Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36, longitude: 15),
													  span: MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60))
		@Published private(set) var locations: [Location]
		@Published var selectedPlace: Location?
		@Published var isUnlocked = false
		@Published var unlockError = false
		@Published var unlockErrorReason = ""

		
		
		let savePath = FileManager.documentsDirectoryURL.appendingPathComponent("SavedPlaces")
		
		init() {
			do {
				let data = try Data(contentsOf: savePath)
				locations = try JSONDecoder().decode([Location].self, from: data)
			} catch {
				locations = []
			}
		}
		
		func save() {
			do {
				let data = try JSONEncoder().encode(locations)
				try data.write(to: savePath, options: [.atomic, .completeFileProtection])
			} catch {
				print("Unable to save locations to: \(savePath)")
			}
		}
		
		func addLocation() {
			let newLocation = Location(id: UUID(),
									   name: "New Location",
									   description: "",
									   latitude: mapRegion.center.latitude,
									   longitude: mapRegion.center.longitude)
			locations.append(newLocation)
			save()
		}
		
		func update(location: Location) {
			guard let selectedPlace = selectedPlace else { return }
			
			if let index = locations.firstIndex(of: selectedPlace) {
				locations[index] = location
				save()
			}
		}
		
		func authenticate() {
			let context = LAContext()
			var error: NSError?
			
			if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
				let reason = "Use biometric authentication to unlock your data."
				
				context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
					if success {
						Task { @MainActor in
							self.isUnlocked = true
						}
					} else {
						//error
						print("Couldn't unlock data")
						Task { @MainActor in
							self.unlockError = true
							self.unlockErrorReason = "Biometric data is invalid."
						}
					}
				}
			} else {
				//handle no biometrics
				print("Device doesn't support biometrics.")
				print("Unlocking anyway for debugging purposes...")
				Task { @MainActor in
					self.unlockError = true
					self.unlockErrorReason = "Device doesn't support biometrics."
				}
			}
		}
	}
}

