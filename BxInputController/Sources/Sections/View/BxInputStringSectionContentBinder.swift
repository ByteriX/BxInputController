/**
 *	@file BxInputStringSectionContentBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binding string data content of section with view
 *	@date 18.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Binding string data content of header section with view
open class BxInputStringHeaderSectionContentBinder<Content: BxInputSectionStringContent, View : BxInputStringSectionContentView> : BxInputBaseSectionContentBinder<Content, View>
{
    override open func update()
    {
        super.update()
        
        view?.contentLabel.font = owner?.settings.headerFont
        view?.contentLabel.textColor = owner?.settings.headerColor
        
        view?.contentLabel.text = content.text
    }
}

/// Binding string data content of footer section with view
open class BxInputStringFooterSectionContentBinder<T: BxInputSectionStringContent> : BxInputBaseSectionContentBinder<T, BxInputStringSectionContentView>
{
    override open func update()
    {
        super.update()
        
        view?.contentLabel.font = owner?.settings.footerFont
        view?.contentLabel.textColor = owner?.settings.footerColor
        
        view?.contentLabel.text = content.text
    }
}

