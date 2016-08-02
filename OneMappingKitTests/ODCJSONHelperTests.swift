//
//  ODCJSONHelperTests.swift
//  ODCJSONHelperTests
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import XCTest
@testable import OneMappingKit

class ODCJSONHelperTests: XCTestCase {

    func testValidJSONString() {
        let json = "{\"a\": 1, \"b\": \"two\"}"
        let dict = ODCJSONHelper.dictionaryFromJSONString(json)
        XCTAssertNotNil(dict)
        XCTAssertNotNil(dict!["a"])
        XCTAssertEqual(1, dict!["a"] as? Int)
        XCTAssertEqual("two", dict!["b"] as? String)
    }

    func testInvalidJSONString() {
        let invalidJSON = "{\"a\": 1, 17}"
        let dict = ODCJSONHelper.dictionaryFromJSONString(invalidJSON)
        XCTAssertNil(dict)
    }

}
