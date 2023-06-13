//
//  ContentView.swift
//  Instafilter
//
//  Created by Or Israeli on 06/05/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
	@State private var image: Image?
	@State private var filterIntensity = 0.5
	@State private var filterRadius = 100.0
	@State private var filterScale = 5.0
	
	@State private var presentingImagePicker = false
	@State private var inputImage: UIImage?
	@State private var proccessedImage: UIImage?
	
	@State private var currentFilter: CIFilter = CIFilter.sepiaTone()
	@State private var presentingFilterSheet = false

	let context = CIContext()
	
	var body: some View {
		NavigationStack {
			VStack {
				ZStack {
					Rectangle()
						.fill(.secondary)
					
					Text("Tap to select a picture")
						.foregroundColor(.white)
						.font(.headline)
					
					image?
						.resizable()
						.scaledToFit()
				}
				.onTapGesture {
					presentingImagePicker = true
				}
				
				HStack {
					Text("Intensity")
						.frame(minWidth: 60)
					
					Slider(value: $filterIntensity)
						.onChange(of: filterIntensity) { _ in applyProcessing() }
				}
				
				//Day 67 - Challenge 2
				HStack {
					Text("Radius")
						.frame(minWidth: 60)
					
					Slider(value: $filterRadius, in: 0...200)
						.onChange(of: filterRadius) { _ in applyProcessing() }
				}
				
				HStack {
					Text("Scale")
						.frame(minWidth: 60)
					
					Slider(value: $filterScale, in: 0...10)
						.onChange(of: filterScale) { _ in applyProcessing() }
				}
				.padding(.bottom)
				
				HStack {
					Button("Change Filter") { presentingFilterSheet = true }
					Spacer()
					
					Text(currentFilter.friendlyName)
						.bold()
					
					Spacer()
					Spacer()
					
					
					Button("Save", action: save)
						//Day 67 - Challenge 1
						.disabled(image == nil)
				}
			}
			.padding([.horizontal, .bottom])
			.navigationTitle("Instafilter")
			.onChange(of: inputImage) { _ in loadImage() }
			.sheet(isPresented: $presentingImagePicker) {
				ImagePicker(image: $inputImage)
			}
			.confirmationDialog("Select a filter", isPresented: $presentingFilterSheet) {
				Group {
					Button("Bloom") { setFilter(CIFilter.bloom()) }
					Button("Crystallize") { setFilter(CIFilter.crystallize()) }
					Button("Dither") { setFilter(CIFilter.dither()) }
					Button("Edges") { setFilter(CIFilter.edges()) }
					Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
					Button("Pinch Distortion") { setFilter(CIFilter.pinchDistortion()) }
					Button("Pixellate") { setFilter(CIFilter.pixellate()) }
					Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
					Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
					Button("Vignette") { setFilter(CIFilter.vignette()) }
				}
				
				
				//Day 67 - Challenge 3
				Group {
					Button("Cancel", role: .cancel) { }
				}
			}
		}
	}
	
	func loadImage() {
		guard let inputImage = inputImage else { return }
		
		let beginImage = CIImage(image: inputImage)
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		applyProcessing()
	}
	
	func setFilter(_ filter: CIFilter) {
		currentFilter = filter
		loadImage()
	}
	
	func applyProcessing() {
		let inputKeys = currentFilter.inputKeys
		
		if inputKeys.contains(kCIInputIntensityKey) {
			currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
		}
		
		if inputKeys.contains(kCIInputRadiusKey) {
			currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
		}
		
		if inputKeys.contains(kCIInputScaleKey) {
			currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
		}
		
		guard let outputImage = currentFilter.outputImage else { return }
		
		if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
			let uiImage = UIImage(cgImage: cgImage)
			proccessedImage = uiImage
			image = Image(uiImage: uiImage)
		}
		
	}
	
	func save() {
		guard let proccessedImage = proccessedImage else { return }
		
		let imageSaver = ImageSaver()
		imageSaver.successHandler = {
			print("Photo saved to user album.")
		}
		imageSaver.errorHandler = {
			print("Error saving photo: \($0.localizedDescription)")
		}
		
		imageSaver.writeToPhotoAlbum(image: proccessedImage )
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
