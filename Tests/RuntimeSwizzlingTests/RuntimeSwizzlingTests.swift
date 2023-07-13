import ObjectiveC
import UIKit

struct Swizzling {

	typealias ViewDidAppearFunction = @convention(c) (UIViewController, Selector, Bool) -> Void
	typealias ViewDidAppearBlock = @convention(block) (UIViewController, Bool) -> Void

	static private func swizzleViewDidAppear(_ class_: AnyClass, to block: @escaping ViewDidAppearBlock) -> IMP? {

		let selector = #selector(UIViewController.viewDidAppear(_:))
		let method: Method? = class_getInstanceMethod(class_, selector)
		let newImplementation: IMP = imp_implementationWithBlock(unsafeBitCast(block, to: AnyObject.self))

		if let method = method {
			let oldImplementation: IMP = method_getImplementation(method)
			method_setImplementation(method, newImplementation)
			return oldImplementation
		} else {
			class_addMethod(class_, selector, newImplementation, "")
			return nil
		}
	}

//	static private func removeViewDidAppearSwizzle(_ class_: AnyClass, originalImplementation: IMP?) {
//		let selector = #selector(UIViewController.viewDidAppear(_:))
//		guard let method: Method = class_getInstanceMethod(class_, selector) else { return }
//		method_setImplementation(method, originalImplementation)
//	}

	static func swizzleViewDidAppear(viewController: UIViewController, to block: @escaping (UIViewController) -> Void) {
		var implementation: IMP?
		let class_ = type(of: viewController)
		let swizzledBlock: ViewDidAppearBlock = { calledViewController, animated in
			let selector = #selector(UIViewController.viewDidAppear(_:))
			if let implementation = implementation {
				let viewDidAppear: ViewDidAppearFunction = unsafeBitCast(implementation, to: ViewDidAppearFunction.self)
				viewDidAppear(calledViewController, selector, animated)
			}
			if viewController == calledViewController {
				block(viewController)
//				removeViewDidAppearSwizzle(class_, originalImplementation: implementation)
			}
		}
		implementation = swizzleViewDidAppear(class_, to: swizzledBlock)
	}
}

import XCTest

final class RuntimeSwizzlingTests: XCTestCase {
	func test() {
		final class SUT: UIViewController {}

		let expectation = XCTestExpectation()
		expectation.expectedFulfillmentCount = 1

		let sut = SUT()
		Swizzling.swizzleViewDidAppear(viewController: sut) { `self` in
			expectation.fulfill()
		}
		sut.viewDidAppear(true)

		wait(for: [expectation])
	}
}
