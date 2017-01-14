//
//  BxInputSection.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSection
{
    open var header: BxInputSectionContent? = nil
    open var rows: [BxInputRow] = []
    open var footer: BxInputSectionContent? = nil
    
    public init(headerText: String? = nil, rows: [BxInputRow], footerText: String? = nil) {
        self.rows = rows
        if let headerText = headerText {
            header = BxInputSectionStringHeader(headerText)
        }
        if let footerText = footerText {
            footer = BxInputSectionStringFooter(footerText)
        }
    }
}
