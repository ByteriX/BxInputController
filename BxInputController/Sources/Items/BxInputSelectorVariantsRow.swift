//
//  BxInputSelectorVariantsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


open class BxInputSelectorVariantsRow : BxInputVariantsRow, BxInputSelectorRow, BxInputStringRow
{
    
    open var isOpened: Bool = false
    open var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    
    public var chield : BxInputChildSelectorVariantsRow
    public var children: [BxInputChildSelectorRow] {
        get {
            return [chield]
        }
    }
    open var stringValue: String? {
        get {
            if let value = value {
                return value.name
            }
            return nil
        }
    }
    
    override public init(title: String? = nil, placeholder: String? = nil, value: BxInputVariantsItem? = nil) {
        chield = BxInputChildSelectorVariantsRow()
        super.init(title: title, placeholder: placeholder, value: value)
        resourceId = "BxInputSelectorCell"
        chield.parent = self
    }
    
}

open class BxInputChildSelectorVariantsRow: BxInputChildSelectorRow
{
    open var resourceId = "BxInputSelectorVariantsCell"
    
    open var title : String? {
        get {
            return parent?.title ?? nil
        }
    }
    open var placeholder : String? {
        get {
            return parent?.placeholder ?? nil
        }
    }
    open var isEnabled : Bool {
        get {
            return parent?.isEnabled ?? false
        }
    }
    
    weak open var parent: BxInputSelectorRow? = nil
}
