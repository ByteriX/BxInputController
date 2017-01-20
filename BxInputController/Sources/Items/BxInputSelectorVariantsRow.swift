//
//  BxInputSelectorVariantsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputSelectorVariantsRow<T: BxInputStringObject> : BxInputVariantsRow<T>, BxInputSelectorRow, BxInputStringRow
{
    override open var resourceId : String {
        get { return "BxInputSelectorCell" }
    }
    override open var estimatedHeight : CGFloat {
        get { return 54 }
    }
    
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
                return value.stringValue
            }
            return nil
        }
    }
    
    override public init(title: String? = nil, placeholder: String? = nil, value: T? = nil) {
        chield = BxInputChildSelectorVariantsRow()
        super.init(title: title, placeholder: placeholder, value: value)
        chield.parent = self
    }
    
}

open class BxInputChildSelectorVariantsRow: BxInputChildSelectorRow
{
    open var resourceId : String {
        get { return "BxInputSelectorVariantsCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 216 }
    }
    
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
