//
//  BxInputSection.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputSection
{
    var header: BxInputSectionContent? = nil
    var rows: [BxInputRow] = []
    var footer: BxInputSectionContent? = nil
    
    init(headerText: String? = nil, rows: [BxInputRow], footerText: String? = nil) {
        self.rows = rows
        if let headerText = headerText {
            header = BxInputSectionStringHeader(headerText)
        }
        if let footerText = footerText {
            footer = BxInputSectionStringFooter(footerText)
        }
    }
}
