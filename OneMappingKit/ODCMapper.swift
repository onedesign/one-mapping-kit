//
//  ODCMapper.swift
//  OneMappingKit
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import Foundation

internal enum ODCMappingDirection {
    case ToJSON
    case FromJSON
}

public class ODCMapper {
    internal var direction: ODCMappingDirection = .FromJSON
    private let object: ODCMappableObject
    private let data: NSMutableDictionary

    internal init(object: ODCMappableObject, data: NSDictionary) {
        self.object = object
        self.data = data.mutableCopy() as! NSMutableDictionary
    }

    internal func update(value: AnyObject?) {
        if _currentKey != nil {
            data[_currentKey!] = value
        }
    }

    internal func required<T>() throws -> T {
        guard let field = _currentKey else {
            throw ODCMappingError.InvalidKey
        }
        guard let ret: T = optional() else {
            throw hasKey(field) ? ODCMappingError.InvalidType(field) : ODCMappingError.NotFound(field)
        }
        return ret
    }

    internal func optional<T>() -> T? {
        return hasKey(_currentKey) ? data[_currentKey!] as? T : nil
    }

    private func hasKey(key: String?) -> Bool {
        return key != nil && data[key!] != nil
    }

    private var _currentKey: String?
    public func key(key: String) -> ODCMapper {
        _currentKey = key
        return self
    }

}

//serialization
extension ODCMapper {

    internal func serialize() -> NSDictionary {
        self.direction = .ToJSON
        self.data.removeAllObjects()

        do {
            try self.object.mapping(self)
        } catch _ {}
        _currentKey = nil

        return data
    }

    internal func fromJSON() throws {
        self.direction = .FromJSON
        try self.object.mapping(self)
        _currentKey = nil
    }

}