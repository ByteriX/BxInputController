//
//  BxInputVariantsItem.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


public protocol BxInputVariantsItem : AnyObject {
    var id: String {get}
    var name: String {get}
}

public class BxInputVariantsValue: BxInputVariantsItem
{
    public var id: String
    public var name: String
    
    public init(id: String, name: String)
    {
        self.id = id
        self.name = name
    }
}
