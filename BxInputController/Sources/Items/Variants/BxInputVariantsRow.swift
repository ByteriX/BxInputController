//
//  BxInputVariantsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputVariantsRow<T : BxInputStringObject> : BxInputRow, BxInputVariants
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
    
    open var items: [T] = []
    open var value: T?
    
    internal var variants: [BxInputStringObject] {
        get { return items }
    }
    internal var selectedVariant: BxInputStringObject? {
        get { return value }
        set(value) {
            if let value = value as? T {
                self.value = value
            } else {
                self.value = nil
            }
        }
    }
    
    public init(title: String? = nil, placeholder: String? = nil, value: T? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
}

open class BxInputVariantsItem: BxInputStringObject
{
    public var id: String
    public var name: String
    
    open var stringValue: String? {
        get { return name }
    }
    
    public init(id: String, name: String)
    {
        self.id = id
        self.name = name
    }
}
