//
//  BxInputRateRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 02/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


class BxInputRateRow: BxInputRow
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
