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
	@IBOutlet weak var detailScrollView: UIScrollView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		loadImage()
		dateTitle()
		shareButton()
		scrollViewConfig()
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
			formatter.dateFormat = "d MMMM yyyy"
			title = formatter.string(from: date)
		} else {
			title = "DateTitle".localized
		}
	}
	
	// MARK: Setup share button from SVG
	private func shareButton() {
		let shareButton = UIBarButtonItem(image: UIImage(named: "shareButton"), style: .plain, target: self, action: #selector(shareAction))
		navigationItem.rightBarButtonItem = shareButton
	}
	
	// MARK: Present Activity View if button was tapped
	@objc private func shareAction() {
		guard let image = detailImageView.image else {
			fatalError("nil image")
		}
		setupActivityView(image: image)
	}
	
	// MARK: ACtivity View configuration
	private func setupActivityView(image: UIImage) {
		let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		activityVC.completionWithItemsHandler = {
			activity, success, _, _ in if activity == .saveToCameraRoll && success == true {
				self.successAlert()
			}
		}
		present(activityVC, animated: true, completion: nil)
	}
	
	// MARK: Present alert if the save was succesful
	private func successAlert() {
		let alert = UIAlertController(title: nil, message: "SuccessAlertMessage".localized, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "SuccessAlertAction".localized, style: .default, handler: { _ in
			alert.dismiss(animated: true, completion: nil)
		}))
		present(alert, animated: true, completion: nil)
	}
	
	
	
	// MARK: Zoom Action setup

	private func scrollViewConfig() {
		detailScrollView.delegate = self
		detailScrollView.minimumZoomScale = 1.0
		detailScrollView.maximumZoomScale = 4.0
		detailScrollView.bounces = false
		detailScrollView.bouncesZoom = false
	}

}

extension DetailViewController: UIScrollViewDelegate {

	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return detailImageView
	}
}
