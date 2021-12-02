//
//  ProductItemViewModel.swift
//  GoodChoice
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation
import RxSwift
import RxCocoa

class ProductItemViewModel {
	private let disposeBag = DisposeBag()

	public var dataSource: Driver<[ProductItem]>

	init(_ data: [ProductItem]) {
		let a = Observable.just(data)
		self.dataSource = a.asDriver(onErrorDriveWith: .empty())
	}

//	public var data: [ProductItem]
//
//	//public var dataSource: Observable<[String]>
//
//	init(_ data: [ProductItem]) {
//		self.data = data
//		//self.dataSource = data.asDriver(onErrorDriveWith: .empty())
//	}
}
