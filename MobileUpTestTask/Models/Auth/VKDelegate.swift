//
//  VKDelegate.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 30.03.2022.
//

import SwiftyVK

var vkDelegate: SwiftyVKDelegate?

final class VKDelegate: SwiftyVKDelegate {
	
	// Configure SwiftyVK
	
	let appId = "8121521"
	let scopes: Scopes = []
	
	init() {
		VK.setUp(appId: appId, delegate: self)
	}
	
	func vkNeedsScopes(for sessionId: String) -> Scopes {
		return scopes
	}
	
	func vkNeedToPresent(viewController: VKViewController) {
		if let rootController = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController {
			rootController.present(viewController, animated: true)
		}
	}
	
	func vkTokenCreated(for sessionId: String, info: [String : String]) {
		print("Token created in \(sessionId) session with info: \(info)")
	}
	
	func vkTokenUpdated(for sessionId: String, info: [String : String]) {
		print("Token updated in \(sessionId) session with info: \(info)")
	}
	
	func vkTokenRemoved(for sessionId: String) {
		print("Token removed in \(sessionId) session")
	}
}
