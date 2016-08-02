//
//  ODCMappingOperator.swift
//  OneMappingKit
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import Foundation

infix operator <~ {}
public func <~ <T>(inout left: T!, right: ODCMapper) throws {
    switch right.direction {
    case .ToJSON:
        right.update(left as? AnyObject)
    case .FromJSON:
        try left = right.required()
    }
}

public func <~ <T>(inout left: T, right: ODCMapper) {
    switch right.direction {
    case .ToJSON:
        right.update(left as? AnyObject)
    case .FromJSON:
        do {
            try left = right.required()
        } catch _ {}
    }
}

public func <~ <T>(inout left: T?, right: ODCMapper) {
    switch right.direction {
    case .ToJSON:
        right.update(left as? AnyObject)
    case .FromJSON:
        left = right.optional()
    }
}