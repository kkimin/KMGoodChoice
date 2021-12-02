import RIBs

protocol FavoriteHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FavoriteHomeComponent: Component<FavoriteHomeDependency>, SuperPayDashboardDependency, CardOnFileDashboardDependency {
	let cardsOnFileRepository: CardOnFileRepository

	var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }	// 이런식으로 전달해서 자식은 send 라는 값 업데이트를 못시킴

	private let balancePublisher: CurrentValuePublisher<Double>

	init(dependency: FavoriteHomeDependency, balance: CurrentValuePublisher<Double>, cardOnFileRepository: CardOnFileRepository) {
		self.balancePublisher = balance
		self.cardsOnFileRepository = cardOnFileRepository
		super.init(dependency: dependency)
	}
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FavoriteHomeBuildable: Buildable {
  func build(withListener listener: FavoriteHomeListener) -> FavoriteHomeRouting
}

final class FavoriteHomeBuilder: Builder<FavoriteHomeDependency>, FavoriteHomeBuildable {
  
  override init(dependency: FavoriteHomeDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: FavoriteHomeListener) -> FavoriteHomeRouting {
	let balancePublisher = CurrentValuePublisher<Double>(0)

	let component = FavoriteHomeComponent(dependency: dependency, balance: balancePublisher, cardOnFileRepository: CardOnFileRepositoryImp())
    let viewController = FavoriteHomeViewController()
    let interactor = FavoriteHomeInteractor(presenter: viewController)
    interactor.listener = listener

	let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
	let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
    return FavoriteHomeRouter(interactor: interactor,
							 viewController: viewController, superPayDashboardBuildable: superPayDashboardBuilder, cardOnFileDashboardBuildable: cardOnFileDashboardBuilder)
  }
}
