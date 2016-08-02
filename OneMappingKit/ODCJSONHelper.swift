//
//  ODCJSONHelper.swift
//  OneMappingKit
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import Foundation

class ODCJSONHelper {
    
    class func dictionaryFromJSONString(json: String) -> NSDictionary? {
        if let data = json.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            } catch {}
        }
        return nil
    }

}