//
//  BxInputVariantsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputVariantsRow : BxInputRow
{
    
    open var resourceId : String {
        get { return "BxInputStandartTextCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var items: [BxInputVariantsItem] = []
    open var value: BxInputVariantsItem?
    
    public init(title: String? = nil, placeholder: String? = nil, value: BxInputVariantsItem? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
}
