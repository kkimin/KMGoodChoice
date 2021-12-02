//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation

struct PaymentMethod: Decodable {
	let id: String
	let name: String
	let digits: String
	let color: String
	let isPrimary: Bool
}
