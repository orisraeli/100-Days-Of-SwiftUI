//
//  CIFilter+FriendlyName.swift
//  Instafilter
//
//  Created by Or Israeli on 10/05/2023.
//
import CoreImage
import Foundation

extension CIFilter {
	var friendlyName: String {
		String(name.trimmingPrefix("CI"))
	}
}
