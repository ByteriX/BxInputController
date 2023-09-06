/**
 *	@file BxInputString.swift
 *	@namespace BxInputController
 *
 *	@details BxInputRow & BxInputItem protocols with String extension
 *	@date 20.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// stringValue protocol for items only (which used with generic types)
public protocol BxInputString: Any
{
    /// string value getter for returning this value
    var stringValue : String? {get}
}

/// stringValue protocol for items & rows
public protocol BxInputStringObject: AnyObject, BxInputString
{ }

/// BxInputString realization
extension String : BxInputString {
    
    /// string value getter for returning this value
    public var stringValue : String? {
        get { return self }
    }
    
}
