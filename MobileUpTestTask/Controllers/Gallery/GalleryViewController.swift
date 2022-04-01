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
        
        // Collection view setup
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        configNavBar()
    }
    
    private func configNavBar() {
        self.navigationItem.title = "Mobile Up Gallery"
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
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
