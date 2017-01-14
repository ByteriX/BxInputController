//
//  BxInputSelectorVariantsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


class BxInputSelectorVariantsRow : BxInputVariantsRow, BxInputSelectorRow, BxInputStringRow
{
    
    var isOpened: Bool = false
    var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    
    var chield : BxInputChildSelectorVariantsRow
    var children: [BxInputChildSelectorRow] {
        get {
            return [chield]
        }
    }
    var stringValue: String? {
        get {
            if let value = value {
                return value.name
            }
            return nil
        }
    }
    
    override init(title: String? = nil, placeholder: String? = nil, value: BxInputVariantsItem? = nil) {
        chield = BxInputChildSelectorVariantsRow()
        super.init(title: title, placeholder: placeholder, value: value)
        resourceId = "BxInputSelectorCell"
        chield.parent = self
    }
    
}

class BxInputChildSelectorVariantsRow: BxInputChildSelectorRow
{
    var resourceId = "BxInputSelectorVariantsCell"
    
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
