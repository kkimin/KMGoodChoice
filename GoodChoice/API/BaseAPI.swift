//
//  BaseAPI.swift
//  GoodChoice
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation
import Moya

enum APIEnvironment: String {
	case dev	= "https://www.gccompany.co.kr/App/json/3.json"
	case test	= "https://test~~"
}

protocol BaseAPI: TargetType {}

extension BaseAPI {
	var baseURL: URL {
		guard let url = URL(string: MoyaNetworkManager.environment.rawValue) else {
			fatalError("fatal error")
		}
		return url
	}

	var path: String { return "" }

	var method: Moya.Method { .post }

	var sampleData: Data { Data() }

	var task: Task { .requestPlain }

	var headers: [String: String]? {
		return ["Content-Type": "application/json"]
	}

	public var validationType: ValidationType {
		return .successCodes
	}
}

struct MoyaNetworkManager {
	fileprivate let provider = MoyaProvider<MultiTarget>()
	static let environment: APIEnvironment = .dev
}
