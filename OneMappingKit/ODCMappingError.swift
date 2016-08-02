//
//  ODCMappingError.swift
//  OneMappingKit
//
//  Created by Peter Compernolle on 8/1/16.
//  Copyright © 2016 One Design Company, LLC. All rights reserved.
//

import Foundation

public enum ODCMappingError: ErrorType {
    case InvalidKey
    case NotFound(String)
    case InvalidType(String)
}