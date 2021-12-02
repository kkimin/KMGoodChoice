//
//  ProductCell.swift
//  GoodChoice
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation
import UIKit

final class ProductCell: UITableViewCell {

	private let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.lineBreakMode = .byTruncatingTail
		label.numberOfLines = 1
		label.tintColor = .black
		label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
		return label
	}()

	private lazy var rateLabel: UILabel = {
		let label = UILabel()
		label.text = "몰라 일단 넣어본다."
		label.lineBreakMode = .byTruncatingTail
		label.numberOfLines = 1
		return label
	}()

	private lazy var thumbnameImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private let favoriteToggle: FavoriteToggle = {
		let toggle = FavoriteToggle()
		toggle.translatesAutoresizingMaskIntoConstraints = false
		return toggle
	}()

	// 오른쪽에 toggle 버튼,

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initUI()
	}

	deinit {
		print("cell deinit")
	}

	private func initUI() {
		contentView.addSubview(nameLabel)
		contentView.backgroundColor = .systemRed
		contentView.addSubview(thumbnameImageView)
		contentView.addSubview(favoriteToggle)
		thumbnameImageView.image = UIImage(systemName: "star")
		thumbnameImageView.tintColor = .blue

		NSLayoutConstraint.activate([
			thumbnameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			thumbnameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			thumbnameImageView.widthAnchor.constraint(equalToConstant: 50),
			thumbnameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

			nameLabel.leadingAnchor.constraint(equalTo: thumbnameImageView.trailingAnchor, constant: 20),
			nameLabel.topAnchor.constraint(equalTo: thumbnameImageView.topAnchor),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),	// 50 + 20 constant로 관리 바람
			favoriteToggle.topAnchor.constraint(equalTo: nameLabel.topAnchor),
			favoriteToggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			favoriteToggle.widthAnchor.constraint(equalToConstant: 50),
			favoriteToggle.heightAnchor.constraint(equalToConstant: 30)
		])
	}

	func setLabel(text: String) {
		nameLabel.text = text
	}

	func bindViewModel(_ viewModel: ProductItem) {
		nameLabel.text = viewModel.name
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		nameLabel.text = ""
		rateLabel.text = ""
		thumbnameImageView.image = nil
	}
}
