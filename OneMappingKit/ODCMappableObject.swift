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
}

extension ODCMappableObject {

    public func fromJSON(data: NSDictionary) throws {
        //TODO
    }

    public func serialize() -> NSDictionary {
        return NSDictionary() //TODO
    }

}