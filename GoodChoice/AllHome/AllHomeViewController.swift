import RIBs
import UIKit
import RxSwift
import RxCocoa
import Then

protocol AllHomePresentableListener: AnyObject {
}

final class AllHomeViewController: UIViewController, AllHomePresentable, AllHomeViewControllable {

	weak var listener: AllHomePresentableListener?

	private lazy var listTableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.register(cellType: ProductCell.self)
		tableView.rowHeight = UITableView.automaticDimension
		return tableView
	}()

	private let disposeBag = DisposeBag()

	init() {
		super.init(nibName: nil, bundle: nil)

		setupViews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		setupViews()

	}

	func updateList(_ viewModels: ProductItemViewModel) {
		viewModels.dataSource
			.drive(listTableView.rx.items) { tableView, index, app in
				return tableView.dequeueReusableCell(
					for: IndexPath(row: index, section: 0),
					cellType: ProductCell.self)
					.then {
						$0.bindViewModel(app)
					}
			}
			.disposed(by: disposeBag)
	}

	private func setupViews() {
		title = "전체"
		tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
		view.backgroundColor = .backgroundColor
		view.addSubview(listTableView)

		NSLayoutConstraint.activate([
			listTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
			listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

extension AllHomeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("didselect")
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
