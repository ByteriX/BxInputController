/**
 *	@file BxInputSectionContent.swift
 *	@namespace BxInputController
 *
 *	@details Protocols for the BxInputSection header/footer
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// base protocol for the BxInputSection header/footer
public protocol BxInputSectionContent : AnyObject {
    
    /// owner of this content
    weak var parent: BxInputSection? {get set}
    
    /// estimated height of content for dynamical size
    var estimatedHeight : CGFloat {get}
    
    /// Make and return Binder for binding section content data with view.
    var binder : BxInputSectionContentBinder {get}
}

/// Protocol for the BxInputSection header/footer with UIView content
public protocol BxInputSectionViewContent : BxInputSectionContent {
    
    /// content of the section item
    var view: UIView {get}
    
}

/// Protocol for the BxInputSection header/footer with UIView content received from the resource with xib name
public protocol BxInputSectionNibContent : BxInputSectionContent {
    
    /// resourceId need for getting view content from xib with the same name, also this id using for register header/foother in the table
    var resourceId : String {get}

}

/// Protocol for the BxInputSection header/footer with only text content
public protocol BxInputSectionStringContent : BxInputSectionNibContent {
    
    /// content of the section item
    var text : String {get}
    
}
