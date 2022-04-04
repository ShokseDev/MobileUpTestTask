//
//  LoginScreenViewController.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 29.03.2022.
//

import UIKit
import SwiftyVK

final class LoginScreenViewController: UIViewController {
	
	
	@IBOutlet weak var authButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		authButtonConfig()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(false)
		// MARK: Login action if user has access token
		if VK.sessions.default.accessToken != nil {
			galleryShow()
		}
	}
	
	// MARK: Authentication function (For greater code cleanliness)
	private func auth() {
		DispatchQueue.global().async {
			VK.sessions.default.logIn(
				onSuccess: { _ in
					DispatchQueue.main.async {
						self.galleryShow()
					}
				},
				onError: { _ in
					DispatchQueue.main.async {
						self.loginAlert()
					}
				}
			)
		}
	}
	
	// MARK: Function for transition to gallery
	private func galleryShow() {
		let root = GalleryViewController(nibName: "GalleryView", bundle: nil)
		let navigationController = UINavigationController(rootViewController: root)
		navigationController.modalPresentationStyle = .fullScreen
		
		self.present(navigationController, animated: true, completion: nil)
	}
	
	// MARK: Alert function
	private func loginAlert() {
		let alert = UIAlertController(title: "LoginAlertTitle".localized, message: "LoginAlertMessage".localized, preferredStyle: .alert)
		let alertOK = UIAlertAction(title: "LoginAlertAction".localized, style: .default)
		alert.addAction(alertOK)
		self.present(alert, animated: true, completion: nil)
	}
	
	// MARK: Auth button action and configuration
	@IBAction func authButtonAction(_ sender: UIButton) {
		// MARK: Login action if user doesn't have access token
		if VK.sessions.default.accessToken == nil {
			auth()
		}
	}
	
	private func authButtonConfig() {
		authButton.setTitle("LoginButton".localized, for: .normal)
		authButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		authButton.layer.cornerRadius = 8
		authButton.layer.masksToBounds = true
	}
	
}
