//
//  GalleryViewController.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 01.04.2022.
//

import UIKit
import SwiftyVK

class GalleryViewController: UIViewController {
	
	public var photoGallery = [Photo]()
	public var photosHaveBeenLoaded = false
	
	private lazy var photoManager: PhotoProtocol = PhotoManager(viewController: self)
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		setupCollectionView()
        setupNavBar()
    }
    
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
		galleryCollectionView.delegate = self
		galleryCollectionView.dataSource = self
		galleryCollectionView.register(UINib(nibName: "GalleryView", bundle: nil), forCellWithReuseIdentifier: "galleryCell")
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

extension GalleryViewController: UICollectionViewDelegate {
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
