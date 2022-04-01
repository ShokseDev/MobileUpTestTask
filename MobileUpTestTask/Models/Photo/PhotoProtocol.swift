//
//  PhotoProtocol.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 01.04.2022.
//

import Foundation

protocol PhotoProtocol {
	func loadPhotos(completion: @escaping (_ success: Bool) -> Void)
}
