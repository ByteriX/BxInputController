/**
 *	@file BxInputSection.swift
 *	@namespace BxInputController
 *
 *	@details Section class with all content data for BxInputController
 *	@date 09.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Section class with all content data for BxInputController
open class BxInputSection
{

    /// metadata of cells for this section
    open var rowBinders: [BxInputRowBinder] = []
    
    /// header content of the section, that showed above rows
    open var header: BxInputSectionContent? = nil
    {
        didSet {
            if let header = header {
                header.parent = self
                headerBinder = header.binder
            } else {
                headerBinder = nil
            }
        }
    }
    
    /// footer content of the section, that showed below rows
    open var footer: BxInputSectionContent? = nil
    {
        didSet {
            if let footer = footer {
                footer.parent = self
                footerBinder = footer.binder
            } else {
                footerBinder = nil
            }
        }
    }

    internal(set) public var headerBinder: BxInputSectionContentBinder? = nil
    internal(set) public var footerBinder: BxInputSectionContentBinder? = nil
    
    /// construction object with text header and/or fother, default headerText/footerText is nil and they won't show
    public init(headerText: String? = nil, rows: [BxInputRow], footerText: String? = nil) {
        for row in rows
        {
            rowBinders.append(row.binder)
        }
        defer {
            if let headerText = headerText {
                header = BxInputSectionStringHeader(headerText)
            }
            if let footerText = footerText {
                footer = BxInputSectionStringFooter(footerText)
            }
        }
    }
}
