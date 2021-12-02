//
//  CardOnFileDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by 60067669 on 2021/11/24.
//

import RIBs

protocol CardOnFileDashboardDependency: Dependency {
	var cardsOnFileRepository: CardOnFileRepository { get }	// 부모에서 요청합니다~
}

final class CardOnFileDashboardComponent: Component<CardOnFileDashboardDependency>, CardOnFileDashboardInteractorDependency {
	var cardsOnFileRepository: CardOnFileRepository { dependency.cardsOnFileRepository }	// 이거는 dashboard builder에서 만들지, parent에서 가져올지 고민해.
}

// MARK: - Builder

protocol CardOnFileDashboardBuildable: Buildable {
    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting
}

final class CardOnFileDashboardBuilder: Builder<CardOnFileDashboardDependency>, CardOnFileDashboardBuildable {

    override init(dependency: CardOnFileDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CardOnFileDashboardListener) -> CardOnFileDashboardRouting {
        let component = CardOnFileDashboardComponent(dependency: dependency)
        let viewController = CardOnFileDashboardViewController()
		let interactor = CardOnFileDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return CardOnFileDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
