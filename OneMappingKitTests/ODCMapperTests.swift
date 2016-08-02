//
//  ODCMapperTests.swift
//  OneMappingKit
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import XCTest
@testable import OneMappingKit

class ODCMapperTests: XCTestCase {

    var data: NSDictionary!
    var mapper: ODCMapper!

    override func setUp() {
        super.setUp()

        data = ["an_int": 1, "b": "two"]
        mapper = ODCMapper(object: ODCMappableObject(), data: data)
    }

    func testUpdateUsesSubscriptKey() {
        let expectedValue = Int(arc4random_uniform(150))
        mapper.key("an_int")
        mapper.update(expectedValue)

        let value: Int? = mapper.optional()
        XCTAssertEqual(expectedValue, value)
    }

    func testUpdateDoesntChangeOtherKeys() {
        mapper.key("an_int")
        mapper.update(2)

        let expectedValue = data["b"] as! String
        mapper.key("b")
        let actualValue: String? = mapper.optional()
        XCTAssertEqual(expectedValue, actualValue)
    }

    func testMapperThrowsWhenAccessingNilRequiredKey() {
        mapper.key("emptyField")
        do {
            let _: AnyObject = try mapper.required()
            XCTAssert(false)
        } catch _ {
            XCTAssert(true)
        }
    }

    func testMapperThrowsWhenRequiredValueFailsToCast() {
        mapper.key("an_int") //Int
        do {
            let _: String = try mapper.required()
            XCTAssert(false)
        } catch _ {
            XCTAssert(true)
        }
    }

    func testMapperAssignsRequiredValue() {
        let expected = data["an_int"] as! Int
        mapper.key("an_int") //Int
        do {
            let actual: Int = try mapper.required()
            XCTAssertNotNil(actual)
            XCTAssertEqual(expected, actual)
        } catch _ {
            XCTAssert(false)
        }
    }

    func testMapperAssignsOptionalValue() {
        let expected = data["an_int"] as! Int
        mapper.key("an_int") //Int
        let actual: Int? = mapper.optional()
        XCTAssertNotNil(actual)
        XCTAssertEqual(expected, actual)
    }
}
