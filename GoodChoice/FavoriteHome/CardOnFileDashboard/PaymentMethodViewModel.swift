//
//  PaymentMethodViewModel.swift
//  MiniSuperApp
//
//  Created by 60067669 on 2021/11/24.
//

import UIKit

struct PaymentMethodViewModel {
	let name: String
	let digits: String
	let color: UIColor

	init(_ paymentMethod: PaymentMethod) {
		name = paymentMethod.name
		digits = "****\(paymentMethod.digits)"
		color = UIColor(hex: paymentMethod.color) ?? .systemRed
	}
}
