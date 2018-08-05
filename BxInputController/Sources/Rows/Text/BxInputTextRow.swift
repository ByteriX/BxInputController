/**
 *	@file BxInputTextRow.swift
 *	@namespace BxInputController
 *
 *	@details Row for putting short text string
 *	@date 09.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Row for putting short text string
open class BxInputTextRow: BxInputValueRow, BxInputString
{

    /// Make and return Binder for binding row with cell.
    open var binder : BxInputRowBinder {
        return BxInputTextRowBinder<BxInputTextRow, BxInputStandartTextCell>(row: self)
    }
    
    open var resourceId : String {
        get { return "BxInputStandartTextCell" }
    }
    open var stringValue : String? {
        get { return value }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var subtitle: String?
    open var placeholder : String?
    open var maxCount : Int?
    open var isEnabled : Bool = true
    
    
    open var value: String? = nil
    
    /// Return true if value for the row is empty
    open var hasEmptyValue: Bool
    {
        if let value = value {
            return value.isEmpty
        }
        return true
    }

    public init(title: String? = nil, subtitle: String? = nil,
                placeholder: String? = nil, maxCount : Int? = nil, value: String? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.maxCount = maxCount
        self.value = value
    }
    
    /// event when value of current row was changed
    open func didChangeValue(){
        //
    }
    
    open var textSettings: BxInputTextSettings = BxInputTextSettings.standart
    
}


