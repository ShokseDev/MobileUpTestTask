//
//  GalleryViewController.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 01.04.2022.
//

import UIKit
import SwiftyVK
import Kingfisher

class GalleryViewController: UIViewController {
	
	public var photoGallery = [Photo]()
	public var photosHaveBeenLoaded = false
	
	private let cellId = "galleryCell"
	private let itemsSpacing: CGFloat = 2
	private let itemsPerRow: CGFloat = 2
	private lazy var photoManager: PhotoProtocol = PhotoManager(viewController: self)
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		setupCollectionView()
        setupNavBar()
		
		DispatchQueue.global(qos: .userInteractive).async {
			self.loadPhotos()
		}
    }
    
	// MARK: Config Navigation Bar and setup logout button
    private func setupNavBar() {
        self.navigationItem.title = "Mobile Up Gallery"
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        
        let button = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(logout))
        button.tintColor = .label
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], for: .normal)
        self.navigationItem.rightBarButtonItem = button
    }
	
	private func setupCollectionView() {
		galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
		galleryCollectionView.isHidden = true
		galleryCollectionView.dataSource = self
		galleryCollectionView.delegate = self
		galleryCollectionView.reloadData()
	}
	
	private func loadPhotos() {
		DispatchQueue.main.async {
			self.activityIndicator.startAnimating()
		}
		photoManager.loadPhotos { (success: Bool) -> Void in
			if success {
				DispatchQueue.main.async {
					self.galleryCollectionView.isHidden = false
					self.activityIndicator.stopAnimating()
					self.photosHaveBeenLoaded = true
					self.galleryCollectionView.reloadData()
				}
			} else {
				self.activityIndicator.stopAnimating()
				print("Fail loading photos in \(#function)")
			}
		}
	}
    
    @objc private func logout() {
        VK.sessions.default.logOut()
        self.dismiss(animated: true, completion: nil)
    }
}

extension GalleryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photoGallery.count
    }
    
	// MARK: Load photos to cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let optCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? GalleryCollectionViewCell
		guard let cell = optCell else {
			fatalError("nil cell in \(#function)")
		}
		cell.cellImageView.image = UIImage(named: "noPhoto")
		if photosHaveBeenLoaded {
			let url = URL(string: photoGallery[indexPath.row].biggestImage.url)
			cell.cellImageView.kf.setImage(with: url)
			activityIndicator.isHidden = true
		}
		return cell
    }
    
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
	
	// MARK: Setup cell size and spacing
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let frameCV = collectionView.frame
		let widhtCell = frameCV.width / CGFloat(itemsPerRow)
		let heightCell = widhtCell

		let spacing = CGFloat(itemsPerRow - 1) * itemsSpacing / CGFloat(itemsPerRow)
		return CGSize(width: widhtCell - spacing, height: heightCell - (itemsSpacing * 2))
	}
	
	// MARK: Transition to Detail view
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let detailVC = DetailViewController()
		detailVC.detailURL = photoGallery[indexPath.row].biggestImage.url
		detailVC.date = photoGallery[indexPath.row].date
		navigationItem.backButtonTitle = ""
		guard let navigationController = navigationController else {
			fatalError("nil navigationController in \(#function)")
		}
		navigationController.navigationBar.tintColor = .black
		navigationController.pushViewController(detailVC, animated: true)
	}
}
