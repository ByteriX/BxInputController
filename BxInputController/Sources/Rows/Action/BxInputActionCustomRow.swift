/**
 *	@file BxInputActionCustomRow.swift
 *	@namespace BxInputController
 *
 *	@details Custom action row implementation with association generic class
 *	@date 11.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Custom action row implementation with association generic class
open class BxInputActionCustomRow<T : BxInputString>: BxInputActionRow
{

    open var binder : BxInputRowBinder {
        return BxInputActionCustomRowBinder<T, BxInputStandartTextCell>(row: self)
    }
    open var resourceId = "BxInputStandartTextCell"
    open var stringValue : String? {
        get { return value?.stringValue }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var subtitle : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var value: T? = nil
    open var handler: ((_ actionRow: BxInputActionRow) -> Void)? = nil
    open var isImmediatelyDeselect: Bool = false
    
    /// Return true if value for the row is empty
    open var hasEmptyValue: Bool
    {
        return value == nil
    }
    
    public init(title: String? = nil, placeholder: String? = nil, value: T? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
    /// event when value of current row was changed
    open func didChangedValue(){
        //
    }
}

/// Action row implementation with association with String
typealias BxInputActionStringRow = BxInputActionCustomRow<String>
