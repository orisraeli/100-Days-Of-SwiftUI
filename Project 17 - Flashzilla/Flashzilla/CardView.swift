//
//  CardView.swift
//  Flashzilla
//
//  Created by Or Israeli on 31/05/2023.
//

import SwiftUI

struct CardView: View {
	let card: Card
	var removal: ((Bool) -> Void)? = nil
	
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	@Environment(\.accessibilityVoiceOverEnabled) var voiceOver
	@State private var isShowingAnswer = false
	@State private var offset = CGSize.zero
	@State private var feedback = UINotificationFeedbackGenerator()
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 25, style: .continuous)
				.fill(
					differentiateWithoutColor
					? .white
					: .white.opacity(1 - Double(abs(offset.width / 50)))
				)
				.background(
					differentiateWithoutColor
					? nil
					: RoundedRectangle(cornerRadius: 25, style: .continuous)
						//Day 91 - Challenge 2
						.fill(offset == .zero ? .white : offset.width > 0 ? .green : .red)
				)
				.shadow(radius: 10)
			
			VStack {
				if voiceOver {
					Text(isShowingAnswer ? card.answer : card.prompt)
						.font(.largeTitle)
						.foregroundColor(.black)
				} else {
					Text(card.prompt)
						.font(.largeTitle)
						.foregroundColor(.black)
					
					if isShowingAnswer {
						Text(card.answer)
							.font(.title)
							.foregroundColor(.gray)
					}
				}
			}
			.padding()
			.multilineTextAlignment(.center)
		}
		.frame(width: 450, height: 250)
		.rotationEffect(.degrees(Double(offset.width / 5)))
		.offset(x: offset.width * 5)
		.opacity(2 - Double(abs(offset.width / 50)))
		.accessibilityAddTraits(.isButton)
		.gesture(
			DragGesture()
				.onChanged { gesture in
					offset = gesture.translation
					feedback.prepare()
				}
				.onEnded { _ in
					if abs(offset.width) > 200 {
						if offset.width > 0 {
							feedback.notificationOccurred(.success)
							removal?(true)

						} else {
							feedback.notificationOccurred(.error)
							removal?(false)
						}
					} else {
						offset = .zero
					}
				}
		)
		.onTapGesture {
			isShowingAnswer.toggle()
		}
		.animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
		CardView(card: Card.example)
    }
}
