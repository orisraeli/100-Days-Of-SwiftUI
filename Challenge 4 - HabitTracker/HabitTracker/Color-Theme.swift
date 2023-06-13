//
//  Color-Theme.swift
//  HabitTracker
//
//  Created by Or Israeli on 25/04/2023.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
	static var darkBackgroundHT: Color {
		Color(red: 0.101, green: 0.094, blue: 0.125, opacity: 1.000)
		
	}
	
	static var lightBackgroundHT: Color {
		Color(red: 0.302, green: 0.281, blue: 0.375, opacity: 1.000)
	}
	
	static var accentColorHT: Color {
		Color(red: 0.482, green: 1.000, blue: 0.329, opacity: 1.000)
	}
}
