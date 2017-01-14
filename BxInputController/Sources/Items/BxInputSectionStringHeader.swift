//
//  BxInputSectionStringHeader.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


open class BxInputSectionStringHeader: BxInputSectionStringContent
{
    open var resourceId = "BxInputStandartHeader"
    open var contentText : String
    
    public init(_ text: String) {
        contentText = text
    }
}
