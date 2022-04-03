//
//  Photo.swift
//  MobileUpTestTask
//
//  Created by Daniil Aleshchenko on 01.04.2022.
//

import Foundation

// MARK: Photo array configuration
struct Photo: Decodable {
	let date: Double
	let info: [PhotoInfo]

	var biggestImage: PhotoInfo {
		var biggestWidth = 0
		var index = 0
		for i in 0 ..< info.count where info[i].width > biggestWidth {
			biggestWidth = info[i].width
			index = i
		}
		return info[index]
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		date = try container.decode(Double.self, forKey: .date)
		info = try container.decode([PhotoInfo].self, forKey: .info)
	}

	enum CodingKeys: String, CodingKey {
		case date
		case info = "sizes"
	}
}

// MARK: Catch photo parameters
struct PhotoInfo: Decodable {
	let height: Int
	let width: Int
	let url: String
	let type: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		height = try container.decode(Int.self, forKey: .height)
		width = try container.decode(Int.self, forKey: .width)
		url = try container.decode(String.self, forKey: .url)
		type = try container.decode(String.self, forKey: .type)
	}

	enum CodingKeys: String, CodingKey {
		case height
		case width
		case url
		case type
	}
}

struct GetPhotosResponse: Decodable {
	let count: Int
	let items: [Photo]

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		count = try container.decode(Int.self, forKey: .count)
		items = try container.decode([Photo].self, forKey: .items)
	}

	enum CodingKeys: String, CodingKey {
		case count
		case items
	}
}

