import RIBs

protocol AppRootInteractable: Interactable,
							  AllHomeListener,
							  FavoriteHomeListener {
	var router: AppRootRouting? { get set }
	var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
	func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {

	private let allHome: AllHomeBuildable
	private let favoriteHome: FavoriteHomeBuildable

	private var allHomeRouting: ViewableRouting?
	private var favoriteHomeRouting: ViewableRouting?
	private var profileHomeRouting: ViewableRouting?

	init(
		interactor: AppRootInteractable,
		viewController: AppRootViewControllable,
		allHome: AllHomeBuildable,
		favoriteHome: FavoriteHomeBuildable
	) {
		self.allHome = allHome
		self.favoriteHome = favoriteHome

		super.init(interactor: interactor, viewController: viewController)
		interactor.router = self
	}

	func attachTabs() {
		let allHomeRouting = allHome.build(withListener: interactor)
		let favoriteHomeRouting = favoriteHome.build(withListener: interactor)

		attachChild(allHomeRouting)
		attachChild(favoriteHomeRouting)

		let viewControllers = [
			NavigationControllerable(root: allHomeRouting.viewControllable),
			favoriteHomeRouting.viewControllable
		]

		viewController.setViewControllers(viewControllers)
	}
}
