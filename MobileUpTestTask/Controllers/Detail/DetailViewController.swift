//
//  DetailViewController.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 03.04.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
	
	public var detailURL: String?
	public var date: Double?
	
	
	@IBOutlet weak var detailImageView: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		loadImage()
		dateTitle()
		shareButton()
		
    }

	// MARK: Load image from gallery
	private func loadImage() {
		detailImageView.image = UIImage(named: "noPhoto")
		if let detailURL = detailURL, let detailURL = URL(string: detailURL) {
			detailImageView.kf.setImage(with: detailURL)
		}
	}
	
	// MARK: Setup date as title
	private func dateTitle() {
		if let date = date {
			let date = Date(timeIntervalSince1970: date)
			let formatter = DateFormatter()
			formatter.dateFormat = "MMM dd, yyyy"
			title = formatter.string(from: date)
		} else {
			title = "No date:("
		}
	}
	
	// MARK: Setup share button from SVG
	private func shareButton() {
		let shareButton = UIBarButtonItem(image: UIImage(named: "shareButton"), style: .plain, target: self, action: #selector(shareAction))
		navigationItem.rightBarButtonItem = shareButton
	}
	
	// MARK: Present Activity View if share button was tapped
	@objc private func shareAction() {
		guard let image = detailImageView.image else {
			fatalError("nil image in \(#function)")
		}
		setupActivityView(image: image)
	}
	
	// MARK: ACtivity View configuration
	private func setupActivityView(image: UIImage) {
		let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		activityVC.completionWithItemsHandler = {
			activity, success, _, _ in if activity == .saveToCameraRoll && success == true {
				self.succecAlert()
			}
		}
		present(activityVC, animated: true, completion: nil)
	}
	
	// MARK: Present alert if the save was succesful
	private func succecAlert() {
		let alert = UIAlertController(title: nil, message: "Image successfully saved to gallery", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
			alert.dismiss(animated: true, completion: nil)
		}))
		present(alert, animated: true, completion: nil)
	}

}
