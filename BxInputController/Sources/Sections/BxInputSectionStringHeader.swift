/**
 *	@file BxInputSectionStringHeader.swift
 *	@namespace BxInputController
 *
 *	@details Class for implementation text content for header of a section
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Class for implementation text content for header of a section
open class BxInputSectionStringHeader: BxInputSectionStringContent
{
    /// xib name, see 'BxInputUtils'
    open var resourceId = "BxInputTextHeaderView"
    /// You may override this for custom size
    open var estimatedHeight : CGFloat = 36
    /// owner
    public var parent: BxInputSection? = nil
    
    /// shown text for header
    open var contentText : String
    
    /// text will shown in the header of a section
    public init(_ text: String) {
        contentText = text
    }
}
