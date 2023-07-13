import RuntimeAssociation
import XCTest

final class RuntimeAssociationTests: XCTestCase {
	func test() {
		class SUT: RuntimeAssociation {
			enum Bar {
				case a
				case b
				case c
			}

			var foo: String? {
				get { self[] }
				set { self[] = newValue }
			}

			var bar: Bar? {
				get { self[] }
				set { self[] = newValue }
			}
		}

		let sut = SUT()
		XCTAssertNil(sut.foo)
		XCTAssertNil(sut.bar)

		sut.foo = "lorem"
		XCTAssertEqual(sut.foo, "lorem")
		sut.bar = .a
		XCTAssertEqual(sut.bar, .a)

		sut.foo = "ipsum"
		XCTAssertEqual(sut.foo, "ipsum")
		sut.bar = .c
		XCTAssertEqual(sut.bar, .c)

		sut.foo = nil
		XCTAssertNil(sut.foo)
		sut.bar = nil
		XCTAssertNil(sut.bar)
	}
}
