//
//  BxInputActionCustomRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 11/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputActionCustomRow<T : BxInputString>: BxInputActionRow
{
    open var resourceId = "BxInputStandartTextCell"
    open var stringValue : String? {
        get { return value?.stringValue }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var value: T? = nil
    open var handler: ((_ actionRow: BxInputActionRow) -> Void)? = nil
    open var isImmediatelyDeselect: Bool = false
    
    public init(title: String? = nil, placeholder: String? = nil, value: T? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
}

typealias BxInputActionStringRow = BxInputActionCustomRow<String>
