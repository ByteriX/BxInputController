//
//  BxInputStandartHeader.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputStandartHeader: BxInputStandartHeaderFooter {
    
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func update(data: BxInputSectionContent)
    {
        super.update(data: data)
        
        contentLabel.font = parent?.settings.headerFont
        contentLabel.textColor = parent?.settings.headerColor
        
        if let textData = data as? BxInputSectionStringContent {
            contentLabel.text = textData.contentText
        }
    }
    
}
