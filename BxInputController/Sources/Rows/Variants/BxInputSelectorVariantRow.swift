/**
 *	@file BxInputSelectorVariantRow.swift
 *	@namespace BxInputController
 *
 *	@details Selector Row for choosing one item from variants
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Selector Row for choosing one item from variant in selector below this row
/// - parameter: T - is associated data model for variant rows, should be inherited from BxInputStringObject
open class BxInputSelectorVariantRow<T: BxInputStringObject> : BxInputVariantRow<T>, BxInputSelectorRow, BxInputString
{
    /// Make and return Binder for binding row with cell.
    override open var binder : BxInputRowBinder {
        return BxInputSelectorVariantRowBinder<T, BxInputSelectorVariantRow<T>, BxInputSelectorCell>(row: self)
    }
    override open var resourceId : String {
        get { return "BxInputSelectorCell" }
    }
    override open var estimatedHeight : CGFloat {
        get { return 54 }
    }
    
    open var isOpened: Bool = false
    open var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    /// When user have activated this row will set first value, if this param true
    /// Default is true
    open var isFirstShownSelect: Bool = true
    
    public var child : BxInputChildSelectorVariantRow<T>
    public var children: [BxInputChildSelectorRow] {
        get {
            return [child]
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
    
    override public init(title: String? = nil, subtitle: String? = nil,
                         placeholder: String? = nil, value: T? = nil)
    {
        child = BxInputChildSelectorVariantRow<T>()
        super.init(title: title, subtitle: subtitle, placeholder: placeholder, value: value)
        child.parent = self
    }
    
    convenience public init(title: String? = nil, subtitle: String? = nil,
                            placeholder: String? = nil, value: T? = nil, isFirstShownSelect: Bool = true)
    {
        self.init(title: title, subtitle: subtitle, placeholder: placeholder, value: value)
        self.isFirstShownSelect = isFirstShownSelect
    }
    
}

/// Child Row which show variant selector below parent row
open class BxInputChildSelectorVariantRow<T: BxInputStringObject>: BxInputChildSelectorRow, BxInputStaticHeight
{
    /// Make and return Binder for binding row with cell.
    open var binder : BxInputRowBinder {
        return BxInputChildSelectorVariantRowBinder<T>(row: self)
    }
    open var resourceId : String = "BxInputChildSelectorVariantCell"
    open var height : CGFloat = 216
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
