//
//  PhotoManager.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 01.04.2022.
//

import Foundation
import SwiftyVK

class PhotoManager: PhotoProtocol {
	
	private var gallery: GalleryViewController
	
	private struct RequestParams {
		static let ownerId = "-128666765"
		static let albumId = "266276915"
		static let photoSizes = "1"
		static let rev = "0"
		static let offset = "0"
		static let count = "30"
	}
	
	private enum RequestError: Error {
		case networkError
		case parsingError
	}
	
	
	func loadPhotos(completion: @escaping (Bool) -> Void) {
		photoRequest { result in
			switch result {
			case let .failure(error):
				print("Error loading photos in \(#function): \(error)")
				completion(false)
			case .success:
				completion(true)
			}
		}
	}
	
	private func photoRequest(completion: @escaping (Result<Bool, RequestError>) -> Void) {
		VK.API.Photos.get([
			.ownerId: RequestParams.ownerId,
			.albumId: RequestParams.albumId,
			.photoSizes: RequestParams.photoSizes,
			.rev: RequestParams.rev,
			.offset: RequestParams.offset,
			.count: RequestParams.count
		]).onSuccess { response in
			do {
				let responseDecoded = try JSONDecoder().decode(GetPhotosResponse.self, from: response)
				self.gallery.photoGallery = responseDecoded.items
				completion(.success(true))
			} catch let parsingError {
				completion(.failure(.parsingError))
				print("Parsing error in \(#function): \(parsingError)")
			}
		}.onError { error in
			print("Request failed with error: \(error)")
			completion(.failure(.networkError))
		}.send()
	}
	
	init(viewController: GalleryViewController) {
		gallery = viewController
	}
}
