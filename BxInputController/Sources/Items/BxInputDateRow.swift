//
//  BxInputDateRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

class BxInputDateRow : BxInputRow
{
    
    var resourceId = "BxInputStandartTextCell"
    
    var title : String?
    var placeholder : String?
    var isEnabled : Bool = true
    
    var value: Date? = nil
    var minimumDate: Date? = nil
    var maximumDate: Date? = nil
    
    init(title: String? = nil, placeholder: String? = nil, value: Date? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
}
