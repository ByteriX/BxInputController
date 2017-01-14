//
//  BxInputSwitchRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

class BxInputSwitchRow: BxInputRow
{
    var resourceId = ""
    
    var title : String?
    var placeholder : String?
    var isEnabled : Bool = true
    
    var value: Bool
    
    init(title: String? = nil, placeholder: String? = nil, value: Bool = false) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
    internal static func cellId() -> String {
        return ""
    }
    
}
