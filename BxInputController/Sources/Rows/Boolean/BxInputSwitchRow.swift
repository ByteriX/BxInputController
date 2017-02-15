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

/// this is not implemented
open class BxInputSwitchRow: BxInputRow
{
    open var resourceId = "BxInputSwitchCell"
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var value: Bool
    
    public init(title: String? = nil, value: Bool = false) {
        self.title = title
        self.value = value
    }
    
}
