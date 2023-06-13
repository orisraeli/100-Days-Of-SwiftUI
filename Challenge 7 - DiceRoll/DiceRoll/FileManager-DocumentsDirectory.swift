//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Or Israeli on 14/05/2023.
//

import Foundation

extension FileManager {
	static var documentsDirectoryURL: URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	
}
