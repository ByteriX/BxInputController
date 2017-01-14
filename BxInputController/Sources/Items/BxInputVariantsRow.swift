//
//  BxInputVariantsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


class BxInputVariantsRow : BxInputRow
{
    
    var resourceId = "BxInputStandartTextCell"
    
    var title : String?
    var placeholder : String?
    var isEnabled : Bool = true
    
    var items: [BxInputVariantsItem] = []
    var value: BxInputVariantsItem?
    
    init(title: String? = nil, placeholder: String? = nil, value: BxInputVariantsItem? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
}
