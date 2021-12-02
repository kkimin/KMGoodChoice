//
//  NetworkManager.swift
//  GoodChoice
//
//  Created by 60067669 on 2021/11/24.
//

import Foundation
import Moya

// 일단 Root로 해두자, 계속 요청할텐데 그거는 고민좀 해보고...!!

enum RootService {
	case getList
}

extension RootService: BaseAPI {

	var method: Moya.Method {
		switch self {
			case .getList:
				return .get
		}
	}
	var sampleData: Data {
		switch self {
			case .getList:
				return "{'name':'\'}".data(using: .utf8)!	// test Data
		}
	}
}
