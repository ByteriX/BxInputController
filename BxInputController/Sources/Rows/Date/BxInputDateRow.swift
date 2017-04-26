/**
 *	@file BxInputDateRow.swift
 *	@namespace BxInputController
 *
 *	@details Row for choosing date from selector with keyboard frame
 *	@date 10.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Row for choosing date from selector with keyboard frame
open class BxInputDateRow : BxInputValueRow
{

    /// Make and return Binder for binding row with cell.
    open var binder : BxInputRowBinder {
        return BxInputDateRowBinder<BxInputDateRow, BxInputStandartTextCell>(row: self)
    }

    
    open var resourceId : String {
        get { return "BxInputStandartTextCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var subtitle: String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var value: Date? = nil
    open var minimumDate: Date? = nil
    open var maximumDate: Date? = nil
    
    /// Return true if value for the row is empty
    open var hasEmptyValue: Bool {
        return value == nil
    }
    
    public init(title: String? = nil, subtitle: String? = nil,
                placeholder: String? = nil, value: Date? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.value = value
    }
    
    /// event when value of current row was changed
    open func didChangedValue(){
        //
    }
    
}
