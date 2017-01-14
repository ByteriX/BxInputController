//
//  BxInputActionRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 11/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

class BxInputActionRow: BxInputStringRow
{
    var resourceId = "BxInputStandartTextCell"
    
    var title : String?
    var placeholder : String?
    var isEnabled : Bool = true
    var stringValue : String? {
        get {
            return value
        }
    }
    
    var value: String? = nil
    var data: Any? = nil
    var handler: ((_ actionRow: BxInputActionRow) -> Void)? = nil
    var isAutomaticDeselect: Bool = true
    
    init(title: String? = nil, placeholder: String? = nil, value: String? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
}
