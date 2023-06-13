//
//  DetailView.swift
//  Bookworm
//
//  Created by Or Israeli on 30/04/2023.
//

import CoreData
import SwiftUI

struct DetailView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.dismiss) var dismiss
	@State private var presentingDeleteAlert = false
	
	let book: Book
	
    var body: some View {
		ScrollView {
			ZStack(alignment: .bottomTrailing) {
				Image(book.genre ?? "Fantasy")
					.resizable()
					.scaledToFit()
				
				Text(book.genre?.uppercased() ?? "FANTASY")
					.font(.caption)
					.fontWeight(.black)
					.padding(8)
					.foregroundColor(.white)
					.background(.black.opacity(0.75))
					.clipShape(Capsule())
					.offset(x: -5, y: -5)
			}
			
			VStack {
				Text(book.author ?? "Unknown author")
					.font(.title)
					.foregroundColor(.secondary)
				
				Text(book.review ?? "No review")
					.padding()
				
				RatingView(rating: .constant(Int(book.rating)))
					.font(.largeTitle)
				
				Text("Date Added: \(book.dateAdded?.formatted(date: .abbreviated, time: .omitted) ?? "Unknown date")")
					.font(.subheadline)
					.foregroundColor(.secondary)
					.padding()
			}
		}
		.alert("Delete Book?", isPresented: $presentingDeleteAlert) {
			Button("Delete", role: .destructive, action: deleteBook)
			Button("Cancel", role: .cancel) { }
		} message: {
			Text("Are you sure you want to delete this book?")
		}
		.toolbar {
			Button {
				presentingDeleteAlert = true
			} label: {
				Label("Delete this book", systemImage: "trash")
			}
		}
		.navigationTitle(book.title ?? "Unknown Book")
		.navigationBarTitleDisplayMode(.inline)
    }
	
	func deleteBook() {
		moc.delete(book)
		try? moc.save()
		
		dismiss()
	}
}

struct DetailView_Previews: PreviewProvider {
	static var dataController = DataController()
	static var moc = dataController.container.viewContext
	
	static var previews: some View {
		let book = Book(context: moc)
		book.title = "Test book"
		book.author = "Test author"
		book.genre = "Fantasy"
		book.rating = 4
		book.review = "This was a great book; I really enjoyed it."
		book.dateAdded = Date.now
		
		return NavigationView {
			DetailView(book: book)
		}
	}
}
