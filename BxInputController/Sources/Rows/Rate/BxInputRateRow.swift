/**
 *	@file BxInputRateRow.swift
 *	@namespace BxInputController
 *
 *	@details Row for select rating
 *	@date 02.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Row for select rating
open class BxInputRateRow: BxInputRow
{
    
    open var resourceId : String {
        get { return "BxInputRateCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var maxValue: Int
    open var width: CGFloat = 130
    open var passiveColor: UIColor? = nil
    open var activeColor: UIColor
    open var value: Float? = nil
    
    public init(title: String? = nil, maxValue: Int = 5, activeColor: UIColor = UIColor.red, value: Float? = nil)
    {
        self.title = title
        self.value = value
        self.maxValue = maxValue
        self.activeColor = activeColor
    }
    
}
