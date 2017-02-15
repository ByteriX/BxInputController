/**
 *	@file BxInputSelectorDateRow.swift
 *	@namespace BxInputController
 *
 *	@details Selector row for choosing date from selector below this row
 *	@date 12.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Row for choosing date from selector below this row
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
    
    public var child : BxInputChildSelectorDateRow
    public var children: [BxInputChildSelectorRow] {
        get {
            return [child]
        }
    }
    
    override public init(title: String? = nil, placeholder: String? = nil, value: Date? = nil) {
        child = BxInputChildSelectorDateRow()
        super.init(title: title, placeholder: placeholder, value: value)
        child.parent = self
    }
    
}

/// Row for selector date. Is single child of BxInputSelectorDateRow
open class BxInputChildSelectorDateRow: BxInputChildSelectorRow, BxInputStaticHeight
{
    open var resourceId : String = "BxInputSelectorDateCell"
    open var height : CGFloat = 216
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
