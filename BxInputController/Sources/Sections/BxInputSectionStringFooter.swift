/**
 *	@file BxInputSectionStringFooter.swift
 *	@namespace BxInputController
 *
 *	@details Class for implementation text content for footer of a section
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Class for implementation text content for footer of a section
open class BxInputSectionStringFooter: BxInputSectionStringContent
{
    /// Make and return Binder for binding section content data with view.
    open var binder: BxInputSectionContentBinder {
        return BxInputStringFooterSectionContentBinder<BxInputSectionStringFooter>(content: self)
    }
    /// xib name, see 'BxInputUtils'
    open var resourceId : String {
        return "BxInputTextFooterView"
    }
    /// You may override this for custom size
    open var estimatedHeight : CGFloat = 36
    /// owner
    public var parent: BxInputSection? = nil
    
    /// shown text for footer
    open var text : String
    
    /// text will shown in the footer of a section
    public init(_ text: String) {
        self.text = text
    }
}
