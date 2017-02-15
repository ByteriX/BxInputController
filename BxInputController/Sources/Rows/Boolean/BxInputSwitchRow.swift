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
open class BxInputSwitchRow: BxInputRow
{
    /// Use for initializing from a xib and register for the table, this have to be uniqueue value
    open var resourceId = "BxInputSwitchCell"
    /// estimated height for the cell (got from resourceId) in the table
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    /// result of user choosing
    open var value: Bool
    
    public init(title: String? = nil, value: Bool = false) {
        self.title = title
        self.value = value
    }
    
}