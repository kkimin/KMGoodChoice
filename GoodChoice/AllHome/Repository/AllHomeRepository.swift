//
//  AllHomeRepository.swift
//  GoodChoice
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation
import Moya
import RxSwift

protocol AllHomeRepository {
	//var productList: ProductItemViewModel? { get }
	func getProductList(_ provider: MoyaProvider<RootService>) -> Single<[ProductItem]> // provider를 어디 선언해둬야되는거였나봐 미친ㅠㅠ
}

final class AllHomeRepositoryImp: AllHomeRepository {
	//var productList: ProductItemViewModel? { getProductList() }
	var disposeBag = DisposeBag()

	func getProductList(_ provider: MoyaProvider<RootService>) -> Single<[ProductItem]> {
		return provider.rx.request(.getList)
			.filterSuccessfulStatusCodes()
			.map(ProductResponseModel.self)
			.map{ $0.product }
			.debug()
	}
}
