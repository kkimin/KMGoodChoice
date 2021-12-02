import RIBs

protocol FavoriteHomeRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
	func attachSuperPayDashboard()
	func attachCardOnFileDashboard()
}

protocol FavoriteHomePresentable: Presentable {
  var listener: FavoriteHomePresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FavoriteHomeListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FavoriteHomeInteractor: PresentableInteractor<FavoriteHomePresentable>, FavoriteHomeInteractable, FavoriteHomePresentableListener {
  
  weak var router: FavoriteHomeRouting?
  weak var listener: FavoriteHomeListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: FavoriteHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.

	router?.attachSuperPayDashboard()
	router?.attachCardOnFileDashboard()
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
}
