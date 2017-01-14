//
//  BxInputActionRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 11/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

open class BxInputActionRow: BxInputStringRow
{
    open var resourceId = "BxInputStandartTextCell"
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    open var stringValue : String? {
        get {
            return value
        }
    }
    
    open var value: String? = nil
    open var data: Any? = nil
    open var handler: ((_ actionRow: BxInputActionRow) -> Void)? = nil
    open var isAutomaticDeselect: Bool = true
    
    public init(title: String? = nil, placeholder: String? = nil, value: String? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
}
