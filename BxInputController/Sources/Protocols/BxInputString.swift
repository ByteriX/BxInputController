//
//  BxInputString.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 20/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

public protocol BxInputString: Any
{
    var stringValue : String? {get}
}

extension String : BxInputString {
    
    public var stringValue : String? {
        get { return self }
    }
    
}
