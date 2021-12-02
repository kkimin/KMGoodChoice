//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by 60067669 on 2021/11/24.
//

import RIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }
	func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol CardOnFileDashboardInteractorDependency {
	var cardsOnFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?

	private let dependency: CardOnFileDashboardInteractorDependency
	private var cancellables: Set<AnyCancellable>

	init(presenter: CardOnFileDashboardPresentable, dependency: CardOnFileDashboardInteractorDependency) {
		self.dependency = dependency
		self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
		dependency.cardsOnFileRepository.cardOnFile.sink { [weak self] (methods) in	// 늘 이렇게 weak self 해줘야하는데
			let viewModels = methods.prefix(5).map(PaymentMethodViewModel.init)
			self?.presenter.update(with: viewModels)
			// data 변환은 어디서 할까요? viewModel을 만들어라
		}.store(in: &cancellables)
    }

    override func willResignActive() {	// 요때  항상 해주면 self capture위에 retain cycle이 없어지긴 해
        super.willResignActive()

		cancellables.forEach{ $0.cancel() }
		cancellables.removeAll()
    }
}
