//
//  CardView.swift
//  MiniSuperApp
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation
import UIKit

class CardView: UIView {

	private let currencyLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.text = "원"
		label.textColor = .white
		return label
	}()

	private let balanceAmountLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.textColor = .white
		return label
	}()

	init(viewModel: PaymentMethodViewModel) {
		super.init(frame: .zero)
		balanceAmountLabel.text = viewModel.name
		setupView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}

	private func setupView() {

		//addSubview(currencyLabel)
		addSubview(balanceAmountLabel)
		NSLayoutConstraint.activate([
			balanceAmountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
			balanceAmountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
}
