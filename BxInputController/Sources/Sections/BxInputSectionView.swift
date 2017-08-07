/**
 *	@file BxInputSectionView.swift
 *	@namespace BxInputController
 *
 *	@details Class for implementation view content for header or footer of a section
 *	@date 17.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Class for implementation view content for header or footer of a section
open class BxInputSectionView : BxInputSectionViewContent, BxInputStaticHeight
{
    /// Make and return Binder for binding section content data with view.
    open var binder: BxInputSectionContentBinder {
        return BxInputBaseSectionContentBinder<BxInputSectionView, UIView>(content: self)
    }
    /// default return size of view, but you may override it
    open var estimatedHeight : CGFloat {
        return height
    }
    /// size for a header/footer/row content
    open var height : CGFloat {
        return view.frame.size.height
    }
    /// owner
    public var parent: BxInputSection? = nil

    /// shown view for header or footer
    open var view: UIView
    
    /// view will shown in the header or footer of a section
    public init(view: UIView) {
        self.view = view
    }
}
