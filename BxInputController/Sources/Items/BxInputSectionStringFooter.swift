//
//  BxInputSectionStringFooter.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSectionStringFooter: BxInputSectionStringContent
{
    open var resourceId = "BxInputStandartFooter"
    open var estimatedHeight : CGFloat = 36
    
    public var parent: BxInputSection? = nil
    open var contentText : String
    
    public init(_ text: String) {
        contentText = text
    }
}
