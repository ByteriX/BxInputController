/**
 *	@file BxInputSelectorTextRow.swift
 *	@namespace BxInputController
 *
 *	@details Selector Row with child row for putting longest text string
 *	@date 02.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Selector Row with child row for putting longest text string
open class BxInputSelectorTextRow : BxInputTextRow, BxInputSelectorRow
{
    /// Make and return Binder for binding row with cell.
    override open var binder : BxInputRowBinder {
        return BxInputSelectorTextRowBinder<BxInputSelectorTextRow, BxInputSelectorCell>(row: self)
    }
    override open var resourceId : String {
        get { return "BxInputSelectorCell" }
    }
    override open var estimatedHeight : CGFloat {
        get { return 54 }
    }
    
    open var isOpened: Bool = false
    open var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    
    public var child : BxInputChildSelectorTextRow
    public var children: [BxInputChildSelectorRow] {
        get {
            return [child]
        }
    }
    
    override public init(title: String? = nil, subtitle: String? = nil,
                         placeholder: String? = nil, maxCount: Int? = nil, value: String? = nil)
    {
        child = BxInputChildSelectorTextRow()
        super.init(title: title, subtitle: subtitle, placeholder: placeholder, maxCount: maxCount, value: value)
        child.parent = self
    }
    
}

/// Child row for BxInputSelectorTextRow with text input field
open class BxInputChildSelectorTextRow: BxInputChildSelectorRow, BxInputStaticHeight, BxInputTextMemoRowProtocol
{
    /// Make and return Binder for binding row with cell.
    open var binder : BxInputRowBinder {
        return BxInputChildSelectorTextRowBinder<BxInputChildSelectorTextRow, BxInputChildSelectorTextCell, BxInputSelectorTextRow>(row: self)
    }
    open var resourceId : String = "BxInputChildSelectorTextCell"
    open var height : CGFloat = 120
    open var estimatedHeight : CGFloat {
        get { return height }
    }
    
    open var title : String? {
        get {
            return parent?.title ?? nil
        }
    }
    open var subtitle : String? {
        get {
            return parent?.subtitle ?? nil
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
            parent?.isEnabled = newValue
        }
    }
    
    weak open var parent: BxInputSelectorRow? = nil
}
