//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation
import Moya

protocol CardOnFileRepository {
	var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
	//var rootProvider: MoyaProvider<RootService> { get }
}

final class CardOnFileRepositoryImp: CardOnFileRepository {
	//var rootProvider: MoyaProvider<RootService> { MoyaProvider<RootService>() }

	var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { makeData() }

	// 여기서 백엔드에서 가져오는거같은데
	//private let paymentMethodSubject: CurrentValuePublisher<[PaymentMethod]>

	init() {
		//self.paymentMethodSubject = makeData()
	}

	private func makeData() -> CurrentValuePublisher<[PaymentMethod]> {
//		rootProvider.request(.getList, completion: { (result) in
//			switch result {
//				case .success(let response):
//					let model = ProductResponseModel.decode(data: response.data)
//					print(model) // rx로 변경해서 data 전달해보자...!
//				case .failure(let error):
//					print(error)
//			}
//		})
		return CurrentValuePublisher<[PaymentMethod]>([PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
				PaymentMethod(id: "0", name: "신한은행", digits: "0123", color: "#f19a38ff", isPrimary: false)])
	}
}

// 이거를 interactor에 선언하는거지
extension Decodable {
	static func decode(data: Data) -> Self? {
		do {
			let result = try JSONDecoder().decode(Self.self, from: data)
			print(data.prettyPrintedJSONString)
			return result
		} catch {
			print(error) // decode 실패한 이유
			return nil
		}
	}
}

extension Data {
	/// JSON Data를 예쁘게 String으로 변환
	var prettyPrintedJSONString: String {
		guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
			  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
			  let prettyPrintedString = String(data: data, encoding: .utf8) else { return "" }
		return prettyPrintedString
	}
}
