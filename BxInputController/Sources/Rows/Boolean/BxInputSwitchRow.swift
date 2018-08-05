/**
 *	@file BxInputSwitchRow.swift
 *	@namespace BxInputController
 *
 *	@details Boolean row with switch button
 *	@date 09.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Boolean row with switch button
open class BxInputSwitchRow: BxInputValueRow
{
    open var binder : BxInputRowBinder {
        return BxInputSwitchRowBinder<BxInputSwitchRow, BxInputSwitchCell>(row: self)
    }
    /// Use for initializing from a xib and register for the table, this have to be uniqueue value
    open var resourceId = "BxInputSwitchCell"
    /// estimated height for the cell (got from resourceId) in the table
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var subtitle : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    /// result of user choosing
    open var value: Bool
    
    /// Return true if value for the row is empty
    open var hasEmptyValue: Bool
    {
        return false
    }
    
    public init(title: String? = nil, subtitle: String? = nil, value: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.value = value
    }
    
    /// event when value of current row was changed
    open func didChangeValue(){
        //
    }
    
}
