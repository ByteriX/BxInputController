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
open class BxInputDateRow : BxInputRow
{
    /// Make and return Binder for binding row with cell.
    open var binder : BxInputRowBinder {
        return BxInputStandartTextRowBinder<BxInputDateRow, BxInputStandartTextCell>(row: self)
    }

    
    open var resourceId : String {
        get { return "BxInputStandartTextCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var value: Date? = nil
    open var minimumDate: Date? = nil
    open var maximumDate: Date? = nil
    
    public init(title: String? = nil, placeholder: String? = nil, value: Date? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
}
