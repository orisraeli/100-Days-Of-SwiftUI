//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Or Israeli on 03/05/2023.
//

import CoreData
import SwiftUI

enum PredicateType: String {
	case beginsWith = "BEGINSWITH[c]"
	case contains = "CONTAINS[c]"
	case smallerThan = "<"
	case largerThan = ">"
	case isInArray = "IN"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
	@FetchRequest var fetchRequest: FetchedResults<T>
	
	// this is our content closure; we'll call this once for each item in the list
	let content: (T) -> Content
	
	var body: some View {
		List(fetchRequest, id: \.self) { singer in
			self.content(singer)
		}
	}
	
	init(filterKey: String,
		 predicate: PredicateType = .contains,
		 filterValue: String,
		 sortDescriptors: [SortDescriptor<T>] = [],
		 @ViewBuilder content: @escaping (T) -> Content) {
		_fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
		self.content = content
	}
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
