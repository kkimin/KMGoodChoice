import RIBs

protocol FavoriteHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener {
	var router: FavoriteHomeRouting? { get set }
	var listener: FavoriteHomeListener? { get set }
}

protocol FavoriteHomeViewControllable: ViewControllable {
	// TODO: Declare methods the router invokes to manipulate the view hierarchy.
	func addDashboard(_ view: ViewControllable)
}

final class FavoriteHomeRouter: ViewableRouter<FavoriteHomeInteractable, FavoriteHomeViewControllable>, FavoriteHomeRouting {

	private let superPayDashboardBuildable: SuperPayDashboardBuildable
	private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
	private var superPayRouting: Routing? // 방어로직
	private var cardOnFilerRouting: Routing? // 방어로직

	// TODO: Constructor inject child builder protocols to allow building children.
	init(interactor: FavoriteHomeInteractable, viewController: FavoriteHomeViewControllable, superPayDashboardBuildable: SuperPayDashboardBuildable, cardOnFileDashboardBuildable: CardOnFileDashboardBuildable) {
		self.superPayDashboardBuildable = superPayDashboardBuildable
		self.cardOnFileDashboardBuildable = cardOnFileDashboardBuildable
		super.init(interactor: interactor, viewController: viewController)
		interactor.router = self
	}

	func attachSuperPayDashboard() {
		if superPayRouting != nil {  // 이렇게 끝내지 않고 보통 똑같은 자식을 두번 하지 말라고 위에 방어로직을 쓴다.
			return
		}
		let router = superPayDashboardBuildable.build(withListener: interactor)

		let dashboard = router.viewControllable
		// 이동이 아니고 붙여 넣을거야
		viewController.addDashboard(dashboard)

		self.superPayRouting = router
		attachChild(router)
	}

	func attachCardOnFileDashboard() {
		if cardOnFilerRouting != nil {  // 이렇게 끝내지 않고 보통 똑같은 자식을 두번 하지 말라고 위에 방어로직을 쓴다.
			return
		}
		let router = cardOnFileDashboardBuildable.build(withListener: interactor)

		let dashboard = router.viewControllable
		// 이동이 아니고 붙여 넣을거야
		viewController.addDashboard(dashboard)

		self.cardOnFilerRouting = router
		attachChild(router)
	}
}
