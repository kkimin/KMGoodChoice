import RIBs
import RxSwift
import RxCocoa
import Moya

protocol AllHomeRouting: ViewableRouting {
	func attachTransportHome()
	func detachTransportHome()
}

protocol AllHomePresentable: Presentable {
	var listener: AllHomePresentableListener? { get set }
	func updateList(_ viewModels: ProductItemViewModel)
}

public protocol AllHomeListener: AnyObject {
	// TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol AllHomeInteracorDependency {
	var allHomeRepository: AllHomeRepository { get }
}

final class AllHomeInteractor: PresentableInteractor<AllHomePresentable>, AllHomeInteractable, AllHomePresentableListener {

	weak var router: AllHomeRouting?
	weak var listener: AllHomeListener?
	private var disposeBag = DisposeBag()

	private let dependency: AllHomeInteracorDependency

	init(presenter: AllHomePresentable, dependency: AllHomeInteracorDependency) {
		self.dependency = dependency
		super.init(presenter: presenter)
		presenter.listener = self
	}

	override func didBecomeActive() {
		super.didBecomeActive()
		let rootProvider = MoyaProvider<RootService>()
		dependency.allHomeRepository.getProductList(rootProvider)
			.subscribe { [weak self] event in
				switch event {
					case .success(let response):
						self?.presenter.updateList(ProductItemViewModel(response))
					case .failure(let error):
						print(error)
				}
			}
			.disposed(by: disposeBag)
	}

	func transportHomeDidTapClose() {
		router?.detachTransportHome()
	}
}
