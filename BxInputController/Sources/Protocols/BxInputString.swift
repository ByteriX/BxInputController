///
///  BxInputString.swift
///  BxInputController
///
///  Created by Sergey Balalaev on 20/01/17.
///  Copyright © 2017 Byterix. All rights reserved.
///

import Foundation

/// stringValue protocol for items & rows
public protocol BxInputStringObject: AnyObject
{
    /// string value getter for returning this value
    var stringValue : String? {get}
}

/// stringValue protocol for items only (which used with generic types)
public protocol BxInputString: Any
{
    /// string value getter for returning this value
    var stringValue : String? {get}
}

extension String : BxInputString {
    
    /// string value getter for returning this value
    public var stringValue : String? {
        get { return self }
    }
    
}
