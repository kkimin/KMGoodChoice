//
//  Builder.swift
//  GoodChoice
//
//  Created by 60067669 on 2021/11/25.
//

import UIKit

@dynamicMemberLookup
public struct With<Base: AnyObject> {

	private var base: Base

	public init(_ base: Base) {
		self.base = base
	}

	public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Base, Value>) -> (Value) -> With<Base> {
		{ [base] value in
			base[keyPath: keyPath] = value
			return With(base)
		}
	}

	public func set<Value>(_ keyPath: ReferenceWritableKeyPath<Base, Value>, to value: Value) -> With<Base> {
		base[keyPath: keyPath] = value
		return With(base)
	}

	@discardableResult
	public func build() -> Base {
		return base
	}
}

protocol Withable: AnyObject {}

extension Withable {
	var builder: With<Self> {
		With(self)
	}
}

extension NSObject: Withable {}

extension With where Base: UIView {
	@discardableResult
	func add(to view: UIView) -> With<Base> {
		base.addSubview(view)
		return self
	}
}
