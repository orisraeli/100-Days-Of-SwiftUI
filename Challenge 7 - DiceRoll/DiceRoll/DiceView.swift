//
//  DiceView.swift
//  DiceRoll
//
//  Created by Or Israeli on 09/06/2023.
//

import SwiftUI

struct Dots: View {
	var body: some View {
		HStack {
			//left column
			VStack {
				Circle()
					.frame(width: 20)
					.padding(.top, 4)
				Spacer()
				Circle()
					.frame(width: 20)
					.padding(.bottom, 4)
			}
			
			//mid column
			Circle()
				.frame(width: 20)
			
			//right column
			VStack {
				Circle()
					.frame(width: 20)
					.padding(.top, 4)
				Spacer()
				Circle()
					.frame(width: 20)
					.padding(.bottom, 4)
			}
		}
		.foregroundColor(.black)
	}
}

struct Dice: View {
	var number: Int?
	
	var body: some View {
		RoundedRectangle(cornerRadius: 10, style: .continuous)
			.foregroundColor(.black)
			.overlay {
				ZStack {
					RoundedRectangle(cornerRadius: 10, style: .continuous)
						.foregroundColor(.white)
						.frame(width: 90, height: 90)
						.overlay {
							if let number = number {
								Text(String(number))
									.font(.largeTitle)
									.foregroundColor(.black)
							} else {
								Dots()
							}
						}
				}
			}
			.frame(width: 100, height: 100)
	}
}

struct DiceView: View {
	var roll: Roll?
	
	var body: some View {
		HStack {
			Dice(number: roll?.num1)
			Dice(number: roll?.num2)
		}
	}
}


struct DiceView_Previews: PreviewProvider {
	static var previews: some View {
		DiceView(roll: Roll())
	}
}
