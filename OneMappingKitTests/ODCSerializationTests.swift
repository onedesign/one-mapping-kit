//
//  ODCSerializationTests.swift
//  OneMappingKit
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import XCTest

class ODCSerializationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testMockObjectWithRequiredFieldsHasValidSerialization() {
        let dict: NSDictionary = ["requiredInt": 1, "requiredString": "test", "stringWithDefault": "default"]
        let mockObject = ODCMockObject(dict)!
        let serialization = mockObject.serialize()
        XCTAssertNotNil(serialization)
        XCTAssertEqual(dict, serialization)
    }

    func testMockObjectWithDefaultHasValidSerialization() {
        let dict: NSDictionary = ["requiredInt": 1, "requiredString": "test"]
        let expectedDict = dict.mutableCopy() as! NSMutableDictionary
        expectedDict.setValue("default", forKey: "stringWithDefault")

        let mockObject = ODCMockObject(dict)!
        let serialization = mockObject.serialize()
        XCTAssertNotNil(serialization)
        XCTAssertEqual(expectedDict, serialization)
    }

}
