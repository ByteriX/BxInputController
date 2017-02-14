//
//  BxInputSwitchRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

//! this is not realized
open class BxInputSwitchRow: BxInputRow
{
    open var resourceId = ""
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var value: Bool
    
    public init(title: String? = nil, placeholder: String? = nil, value: Bool = false) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
}
