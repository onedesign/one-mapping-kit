//
//  ODCMockObject.swift
//  OneMappingKit
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import Foundation
import OneMappingKit

class ODCMockObject: ODCMappableObject {
    var requiredInt: Int!
    var requiredString: String!

    var optionalInt: Int?
    var optionalString: String?
    var stringWithDefault: String = "default"

    override func mapping(mapper: ODCMapper) throws {
        try requiredInt <~ mapper.key("requiredInt")
        try requiredString <~ mapper.key("requiredString")

        optionalInt <~ mapper.key("optionalInt")
        optionalString <~ mapper.key("optionalString")
        stringWithDefault <~ mapper.key("stringWithDefault")
    }
}