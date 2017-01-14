//
//  BxInputVariantsItem.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


protocol BxInputVariantsItem : AnyObject {
    var id: String {get}
    var name: String {get}
}

class BxInputVariantsValue: BxInputVariantsItem
{
    var id: String
    var name: String
    
    init(id: String, name: String)
    {
        self.id = id
        self.name = name
    }
}
