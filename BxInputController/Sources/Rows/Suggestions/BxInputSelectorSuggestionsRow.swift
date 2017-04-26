/**
 *	@file BxInputSelectorSuggestionsRow.swift
 *	@namespace BxInputController
 *
 *	@details Selector row for choosing single item from suggestion. Selector is shown below this row
 *	@date 12.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Selector row for choosing single item from suggestion. Selector is shown below this row
/// - parameter: T - is associated data model for suggestion rows, should be inherited from BxInputChildSelectorRow
open class BxInputSelectorSuggestionsRow<T : BxInputChildSelectorRow> : BxInputValueRow, BxInputString, BxInputParentSelectorSuggestionsRow
{
    /// Make and return Binder for binding row with cell.
    open var binder : BxInputRowBinder {
        return BxInputSelectorRowBinder<BxInputSelectorSuggestionsRow, BxInputSelectorCell>(row: self)
    }
    open var resourceId : String {
        get { return "BxInputSelectorCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 54 }
    }
    
    open var title : String?
    open var subtitle: String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    open var stringValue: String? {
        get {
            if let item = selectedChild {
                if let item = selectedChild as? BxInputString {
                    return item.stringValue
                } else {
                    return item.title
                }
            }
            return nil
        }
    }
    // this is doesn't use
    public var timeForAutoselection: TimeInterval {
        get { return 0.0 }
    }
    open var isOpened: Bool = false
    
    open var value: T? {
        get { return selectedChild as? T}
        set { selectedChild = value}
    }
    public var selectedChild: BxInputChildSelectorRow? = nil
    internal(set) public var children: [BxInputChildSelectorRow]
    {
        didSet {
            for child in children {
                child.parent = self
            }
        }
    }
    
    /// Return true if value for the row is empty
    open var hasEmptyValue: Bool
    {
        return value == nil
    }
    
    public init(title: String? = nil, subtitle: String? = nil,
                placeholder: String? = nil, children: [T] = [])
    {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.children = children
    }
    
    open func setChildren(_ children: [T]) {
        self.children = children
    }
    
    /// event when value of current row was changed
    open func didChangedValue(){
        //
    }
    
}

