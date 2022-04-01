//
//  GalleryViewController.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 01.04.2022.
//

import UIKit
import SwiftyVK

class GalleryViewController: UIViewController {

	@IBOutlet weak var galleryCollectionView: UICollectionView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

       configNavBar()
    }

	private func configNavBar() {
		self.navigationItem.title = "Mobile Up Gallery"
		self.navigationController?.navigationBar.shadowImage = UIColor.systemBackground.image()
		self.navigationController?.navigationBar.barTintColor = .systemBackground
		
		let button = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(logout))
		button.tintColor = .label
		button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], for: .normal)
		self.navigationItem.rightBarButtonItem = button
	}
	
	@objc private func logout() {
		VK.sessions.default.logOut()
		self.dismiss(animated: true, completion: nil)
	}
}

// extension for NavigationBar background color
extension UIColor {
	func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
		return UIGraphicsImageRenderer(size: size).image { rendererContext in
			self.setFill()
			rendererContext.fill(CGRect(origin: .zero, size: size))
		}
	}
}
