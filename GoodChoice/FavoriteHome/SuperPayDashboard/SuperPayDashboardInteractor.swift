//
//  SuperPayDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by 60067669 on 2021/11/22.
//

import RIBs
import Combine

protocol SuperPayDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SuperPayDashboardPresentable: Presentable {
    var listener: SuperPayDashboardPresentableListener? { get set }

	func updateBalance(_ balance: String)
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SuperPayDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol SuperPayDashboardInteractorDependency { // 이거는 만든건데, 우리가 init 수정할때마다 추가할게 많아지지 계속 왓다갓다 고쳐야하고 그러니까 그냥 이렇게 프로토콜로 선언해두는거야
	var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class SuperPayDashboardInteractor: PresentableInteractor<SuperPayDashboardPresentable>, SuperPayDashboardInteractable, SuperPayDashboardPresentableListener {

    weak var router: SuperPayDashboardRouting?
    weak var listener: SuperPayDashboardListener?

	private let dependency: SuperPayDashboardInteractorDependency

	private var cancellabels: Set<AnyCancellable>

	init(presenter: SuperPayDashboardPresentable, dependency: SuperPayDashboardInteractorDependency) {
		self.dependency = dependency
		self.cancellabels = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
		dependency.balance.sink { [weak self] (balance) in	// 값을 업데이트 할때는 presenter
			self?.presenter.updateBalance(String(balance))
		}.store(in: &cancellabels)

    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
