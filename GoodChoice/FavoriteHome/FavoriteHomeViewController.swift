import RIBs
import UIKit

protocol FavoriteHomePresentableListener: AnyObject {
	// TODO: Declare properties and methods that the view controller can invoke to perform
	// business logic, such as signIn(). This protocol is implemented by the corresponding
	// interactor class.
}

final class FavoriteHomeViewController: UIViewController, FavoriteHomePresentable, FavoriteHomeViewControllable {

	weak var listener: FavoriteHomePresentableListener?

	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		stackView.spacing = 4
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

	private let label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private func setupViews() {
		title = "즐겨찾기"
		tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
		view.backgroundColor = .white
		view.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}

	func addDashboard(_ view: ViewControllable) {
		let vc = view.uiviewController

		addChild(vc) // 이런식으로 라이프 사이클을 지킴
		stackView.addArrangedSubview(vc.view)
		vc.didMove(toParent: self)
	}

}
