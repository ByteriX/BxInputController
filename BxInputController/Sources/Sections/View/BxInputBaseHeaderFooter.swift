/**
 *	@file BxInputBaseHeaderFooter.swift
 *	@namespace BxInputController
 *
 *	@details Base view content class of header or footer for a section
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Base view content class of header or footer for a section
open class BxInputBaseHeaderFooter : UITableViewHeaderFooterView
{
    /// owner
    weak open var parent: BxInputController? = nil
    /// data model of section content
    internal(set) public var data: BxInputSectionContent? = nil
    
    /// call before showing view when need update content
    public func update(data: BxInputSectionContent)
    {
        self.data = data
    }
    
}
