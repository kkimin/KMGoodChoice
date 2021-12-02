import RIBs
import UIKit

protocol AppRootDependency: Dependency {
}

final class AppRootComponent: Component<AppRootDependency>, AllHomeDependency, FavoriteHomeDependency  {
	let allHomeRepository: AllHomeRepository

	init(dependency: AppRootDependency, allHomeRepository: AllHomeRepository) {
		self.allHomeRepository = allHomeRepository
		super.init(dependency: dependency)
	}
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
	func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

	override init(dependency: AppRootDependency) {
		super.init(dependency: dependency)
	}

	func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler) {

		let component = AppRootComponent(dependency: dependency, allHomeRepository: AllHomeRepositoryImp())

		let tabBar = RootTabBarController()

		let interactor = AppRootInteractor(presenter: tabBar)

		let allHome = AllHomeBuilder(dependency: component)
		let favoriteHome = FavoriteHomeBuilder(dependency: component)
		let router = AppRootRouter(
			interactor: interactor,
			viewController: tabBar,
			allHome: allHome,
			favoriteHome: favoriteHome
		)

		return (router, interactor)
	}
}
