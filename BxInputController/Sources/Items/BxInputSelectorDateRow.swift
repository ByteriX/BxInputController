//
//  BxInputSelectorDateRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 12/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorDateRow : BxInputDateRow, BxInputSelectorRow
{
    override open var resourceId : String {
        get { return "BxInputSelectorCell" }
    }
    override open var estimatedHeight : CGFloat {
        get { return 54 }
    }
    
    open var isOpened: Bool = false
    open var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    
    public var chield : BxInputChildSelectorDateRow
    public var children: [BxInputChildSelectorRow] {
        get {
            return [chield]
        }
    }
    
    override public init(title: String? = nil, placeholder: String? = nil, value: Date? = nil) {
        chield = BxInputChildSelectorDateRow()
        super.init(title: title, placeholder: placeholder, value: value)
        chield.parent = self
    }
    
}

open class BxInputChildSelectorDateRow: BxInputChildSelectorRow
{
    open var resourceId : String {
        get { return "BxInputSelectorDateCell" }
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
