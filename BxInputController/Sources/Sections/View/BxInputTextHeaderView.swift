/**
 *	@file BxInputTextHeaderView.swift
 *	@namespace BxInputController
 *
 *	@details View for showing text content of header for a section
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// View for showing text content of header for a section
open class BxInputTextHeaderView: BxInputBaseHeaderFooterView {
    
    /// text content label
    @IBOutlet weak open var contentLabel: UILabel!

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func update(data: BxInputSectionContent)
    {
        super.update(data: data)
        
        contentLabel.font = parent?.settings.headerFont
        contentLabel.textColor = parent?.settings.headerColor
        
        if let textData = data as? BxInputSectionStringContent {
            contentLabel.text = textData.contentText
        }
    }
    
}
