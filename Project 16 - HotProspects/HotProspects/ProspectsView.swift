//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Or Israeli on 25/05/2023.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
	enum FilterType {
		case none, contacted, uncontacted
	}
	
	@EnvironmentObject var prospects: Prospects
	@State private var isPresentingScanner = false
	@State private var isPresentingSortDialog = false
	
	let filter: FilterType
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(filteredProspects) { prospect in
					HStack {
						//Day 85 - Challenge 1
						if filter == .none {
							Image(systemName: prospect.isContacted ? "person.fill.checkmark" : "person.fill.xmark")
								.font(.title)
						}
						
						VStack(alignment: .leading) {
							Text(prospect.name)
								.font(.headline)
							
							Text(prospect.emailAddress)
								.foregroundColor(.secondary)
						}
						.swipeActions {
							if prospect.isContacted {
								Button {
									prospects.toggleIsContacted(for: prospect)
								} label: {
									Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
								}
								.tint(.blue)
							} else {
								Button {
									prospects.toggleIsContacted(for: prospect)
								} label: {
									Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
								}
								.tint(.green)
								
								Button {
									addNotification(for: prospect)
								} label: {
									Label("Remind Me", systemImage: "bell")
								}
								.tint(.orange)
							}
						}
					}
				}
			}
			.navigationTitle(title)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						isPresentingScanner = true
					} label: {
						Label("Scan", systemImage: "qrcode.viewfinder")
					}
				}
				
				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						isPresentingSortDialog = true
					} label: {
						Label("Sort", systemImage: "line.3.horizontal.decrease.circle")
					}
				}
			}
			.sheet(isPresented: $isPresentingScanner) {
				CodeScannerView(codeTypes: [.qr], simulatedData: "Or Israeli\nor@orisraeli.com", completion: handleScan)
			}
			
			//Day 85 - Challenge 3
			.confirmationDialog("Sort by", isPresented: $isPresentingSortDialog) {
				Button("Sort by Name") {
					prospects.sortByName()
				}
				
				Button("Sort by Recent") {
					prospects.sortByDate()
				}
			}
		}
	}
	
	var title: String {
		switch filter {
			case .none:
				return "Everyone"
			case .contacted:
				return "Contacted People"
			case .uncontacted:
				return "Uncontacted People"
		}
	}
	
	var filteredProspects: [Prospect] {
		switch filter {
			case .none:
				return prospects.people
			case .contacted:
				return prospects.people.filter { $0.isContacted }
			case .uncontacted:
				return prospects.people.filter { !$0.isContacted }
		}
	}
	
	func handleScan(result: Result<ScanResult, ScanError>) {
		isPresentingScanner = false
		
		switch result {
			case .success(let success):
				let details = success.string.components(separatedBy: "\n")
				guard details.count == 2 else { return }
				
				let person = Prospect()
				person.name = details[0]
				person.emailAddress = details[1]
				person.dateCreated  = Date.now
				prospects.add(person)
				
			case .failure(let failure):
				print("Scanning failed: \(failure.localizedDescription)")
		}
	}
	
	func addNotification(for prospect: Prospect) {
		let center = UNUserNotificationCenter.current()
		
		let addRequest = {
			let content = UNMutableNotificationContent()
			content.title = "Contact \(prospect.name)"
			content.subtitle = prospect.emailAddress
			content.sound = UNNotificationSound.default
			
			var dateComponents = DateComponents()
			dateComponents.hour = 9
			//			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
			
			let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
			center.add(request)
		}
		
		center.getNotificationSettings { settings in
			if settings.authorizationStatus == .authorized {
				addRequest()
			} else {
				center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						addRequest()
					} else {
						print("notifications request denied.")
					}
				}
			}
		}
	}
}

struct ProspectsView_Previews: PreviewProvider {
	static var previews: some View {
		ProspectsView(filter: .none)
			.environmentObject(Prospects())
	}
}
