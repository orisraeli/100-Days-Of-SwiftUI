//
//  CachedUser+CoreDataProperties.swift
//  FriendsList
//
//  Created by Or Israeli on 05/05/2023.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friend: NSSet?
	
	var wrappedId: String {
		id ?? "UnknownID"
	}
	
	var wrappedName: String {
		name ?? "Unknown Name"
	}
	
	var wrappedCompany: String {
		company ?? "Unknown Company"
	}
	
	var wrappedEmail: String {
		email ?? "Unknown Email"
	}
	
	var wrappedAddress: String {
		address ?? "Unknown Address"
	}
	
	var wrappedAbout: String {
		about ?? "Unknown About"
	}
	
	var wrappedTags: String {
		tags ?? "Unkown tags"
	}
	
	public var tagsArray: [String] {
		wrappedTags.components(separatedBy: ",")
	}
	
	var wrappedRegistered: Date {
		registered ?? Date.now
	}
	
	var formattedDate: String {
		wrappedRegistered.formatted(date: .abbreviated, time: .omitted)
	}
	
	public var friendsArray: [CachedFriend] {
		let set = friend as? Set<CachedFriend> ?? []
		return set.sorted {
			$0.wrappedName < $1.wrappedName
		}
	}

}

// MARK: Generated accessors for friend
extension CachedUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CachedFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CachedFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
