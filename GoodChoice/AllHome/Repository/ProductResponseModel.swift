//
//  ProductResponseModel.swift
//  GoodChoice
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation

struct ProductResponseModel: Decodable {
	let msg: String
	let totalCount: Int
	let product: [ProductItem]

	enum CodingKeys: CodingKey {
		case msg
		case data
		case totalCount
		case product
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount) ?? 0
		self.msg = try container.decodeIfPresent(String.self, forKey: .msg) ?? ""
		let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
		self.product = try dataContainer.decodeIfPresent(Array.self, forKey: .product) ?? []
	}
}

struct ProductItem: Decodable {
	let id: Int
	let name: String
	let thumbnail: String
	let rate: Double
	let imagePath: String	// 여기서부터 중첩된 애들
	let subject: String
	let price: Int

	enum CodingKeys: CodingKey {
		case id
		case name
		case thumbnail
		case rate
		case description
		case imagePath
		case subject
		case price
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
		self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
		self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
		self.rate = try container.decodeIfPresent(Double.self, forKey: .id) ?? 0.0
		let descriptionContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .description)
		self.imagePath = try descriptionContainer.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
		self.subject = try descriptionContainer.decodeIfPresent(String.self, forKey: .subject) ?? ""
		self.price = try descriptionContainer.decodeIfPresent(Int.self, forKey: .price) ?? 0
	}
}
