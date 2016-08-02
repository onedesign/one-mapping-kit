//
//  ODCMappableObject.swift
//  OneMappingKit
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import Foundation

public class ODCMappableObject: NSObject {

    public convenience init?(json: String) {
        if let data = ODCJSONHelper.dictionaryFromJSONString(json) {
            self.init(data)
        }
        return nil
    }

    public convenience init?(_ data: NSDictionary) {
        self.init()

        do {
            try self.fromJSON(data)
        } catch _ {
            return nil
        }
    }

    //protocol methods declared in extensions cannot be overridden "yet"
    public func mapping(mapper: ODCMapper) throws {
        fatalError("Must override ODCMappableObject:mapping:mapper")
    }
}

extension ODCMappableObject {

    public func fromJSON(data: NSDictionary) throws {
        try ODCMapper(object: self, data: data).fromJSON()
    }

    public func serialize() -> NSDictionary {
        return ODCMapper(object: self, data: NSDictionary()).serialize()
    }

}