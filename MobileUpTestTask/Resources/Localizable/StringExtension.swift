//
//  StringExtension.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 04.04.2022.
//

import Foundation
extension String {
	var localized: String {
		return NSLocalizedString(self, comment: "")
	}
}
