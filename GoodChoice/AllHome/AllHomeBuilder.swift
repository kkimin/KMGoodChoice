import RIBs

protocol AllHomeDependency: Dependency {
	var allHomeRepository: AllHomeRepository { get }	// 부모에서 가져오자.
}

final class AllHomeComponent: Component<AllHomeDependency>, TransportHomeDependency, AllHomeInteracorDependency {
	var allHomeRepository: AllHomeRepository { dependency.allHomeRepository }
}

// MARK: - Builder

public protocol AllHomeBuildable: Buildable {
  func build(withListener listener: AllHomeListener) -> ViewableRouting
}

final class AllHomeBuilder: Builder<AllHomeDependency>, AllHomeBuildable {
  
  public override init(dependency: AllHomeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: AllHomeListener) -> ViewableRouting {
    let component = AllHomeComponent(dependency: dependency)
    let viewController = AllHomeViewController()
	let interactor = AllHomeInteractor(presenter: viewController, dependency: component)
    interactor.listener = listener
    
    let transportHomeBuilder = TransportHomeBuilder(dependency: component)
    
    return AllHomeRouter(
      interactor: interactor,
      viewController: viewController,
      transportHomeBuildable: transportHomeBuilder
    )
  }
}
