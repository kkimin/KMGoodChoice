//
//  CardOnFileDashboardViewController.swift
//  MiniSuperApp
//
//  Created by 60067669 on 2021/11/24.
//

import RIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CardOnFileDashboardViewController: UIViewController, CardOnFileDashboardPresentable, CardOnFileDashboardViewControllable {
	func update(with viewModels: [PaymentMethodViewModel]) {
		balanceStackView.arrangedSubviews.forEach {
			$0.removeFromSuperview()
		} // [PaymentMethodViewModel] -> [PaymentMethodView] 이런거 보면 map 과 flatMap을 써야겟다는 생각이 들어야함
		let views = viewModels.map(CardView.init)

		views.forEach {
			balanceStackView.addArrangedSubview($0)
			$0.backgroundColor = .systemGray
		}

		let heightConstraints = views.map{ $0.heightAnchor.constraint(equalToConstant: 50)}
		NSLayoutConstraint.activate(heightConstraints)
	}
	

    weak var listener: CardOnFileDashboardPresentableListener?

	private let headerStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		stackView.axis = .horizontal
		return stackView
	}()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.text = "슈퍼페이 잔고"
		return label
	}()

	private lazy var topupButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("충전하기", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.addTarget(self, action: #selector(topupButtonDidTap), for: .touchUpInside)
		return button
	}()

	private let balanceStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		stackView.axis = .vertical
		stackView.spacing = 10
		return stackView
	}()

	init() {
		super.init(nibName: nil, bundle: nil)

		setupViews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		setupViews()
	}

	private func setupViews() {
		view.addSubview(headerStackView)

		headerStackView.addArrangedSubview(titleLabel)
		headerStackView.addArrangedSubview(topupButton)

		view.addSubview(balanceStackView)

		NSLayoutConstraint.activate([
			headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
			headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

			balanceStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
			balanceStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			balanceStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			balanceStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
		])
	}

	@objc
	private func topupButtonDidTap() {

	}
}
