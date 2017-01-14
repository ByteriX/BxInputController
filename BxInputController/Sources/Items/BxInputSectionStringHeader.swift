//
//  BxInputSectionStringHeader.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


class BxInputSectionStringHeader: BxInputSectionStringContent
{
    var resourceId = "BxInputStandartHeader"
    var contentText : String
    
    init(_ text: String) {
        contentText = text
    }
}
