//
//  BxInputStringSectionContentBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 18/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

class BxInputStringFooterSectionContentBinder<T: BxInputSectionStringContent> : BxInputBaseSectionContentBinder<T, BxInputStringSectionContentView>
{
    override open func update()
    {
        super.update()
        
        view?.contentLabel.font = owner?.settings.footerFont
        view?.contentLabel.textColor = owner?.settings.footerColor
        
        view?.contentLabel.text = content.text
    }
}

class BxInputStringHeaderSectionContentBinder<T: BxInputSectionStringContent> : BxInputBaseSectionContentBinder<T, BxInputStringSectionContentView>
{
    override open func update()
    {
        super.update()
        
        view?.contentLabel.font = owner?.settings.headerFont
        view?.contentLabel.textColor = owner?.settings.headerColor
        
        view?.contentLabel.text = content.text
    }
}
