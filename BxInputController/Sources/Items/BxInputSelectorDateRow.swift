//
//  BxInputSelectorDateRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 12/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

class BxInputSelectorDateRow : BxInputDateRow, BxInputSelectorRow
{
    
    var isOpened: Bool = false
    var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    
    var chield : BxInputChildSelectorDateRow
    var children: [BxInputChildSelectorRow] {
        get {
            return [chield]
        }
    }
    
    override init(title: String? = nil, placeholder: String? = nil, value: Date? = nil) {
        chield = BxInputChildSelectorDateRow()
        super.init(title: title, placeholder: placeholder, value: value)
        resourceId = "BxInputSelectorCell"
        chield.parent = self
    }
    
}

class BxInputChildSelectorDateRow: BxInputChildSelectorRow
{
    var resourceId = "BxInputSelectorDateCell"
    
    var title : String? {
        get {
            return parent?.title ?? nil
        }
    }
    var placeholder : String? {
        get {
            return parent?.placeholder ?? nil
        }
    }
    var isEnabled : Bool {
        get {
            return parent?.isEnabled ?? false
        }
    }
    
    weak var parent: BxInputSelectorRow? = nil
}
