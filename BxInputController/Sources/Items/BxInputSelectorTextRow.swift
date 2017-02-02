//
//  BxInputSelectorTextRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 02/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputSelectorTextRow : BxInputTextRow, BxInputSelectorRow
{
    override open var resourceId : String {
        get { return "BxInputSelectorCell" }
    }
    override open var estimatedHeight : CGFloat {
        get { return 54 }
    }
    
    open var isOpened: Bool = false
    open var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    
    public var chield : BxInputChildSelectorTextRow
    public var children: [BxInputChildSelectorRow] {
        get {
            return [chield]
        }
    }
    
    override public init(title: String? = nil, placeholder: String? = nil, value: String? = nil) {
        chield = BxInputChildSelectorTextRow()
        super.init(title: title, placeholder: placeholder, value: value)
        chield.parent = self
    }
    
}

open class BxInputChildSelectorTextRow: BxInputChildSelectorRow, BxInputStaticHeight
{
    open var resourceId : String = "BxInputSelectorTextCell"
    open var height : CGFloat = 120
    open var estimatedHeight : CGFloat {
        get { return height }
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
        set {
            parent?.isEnabled = isEnabled
        }
    }
    
    weak open var parent: BxInputSelectorRow? = nil
}
