//
//  GalleryCollectionViewCell.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 01.04.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
	
	// MARK: Setup Image View
	public let cellImageView: UIImageView = {
		let ImageView = UIImageView()
		ImageView.image = UIImage(named: "noPhoto")
		ImageView.translatesAutoresizingMaskIntoConstraints = false
		ImageView.contentMode = .scaleAspectFill
		ImageView.clipsToBounds = true
		return ImageView
	}()


	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpImageView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Image View constraints 
	private func setUpImageView() {
		contentView.addSubview(cellImageView)
		cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}

}
