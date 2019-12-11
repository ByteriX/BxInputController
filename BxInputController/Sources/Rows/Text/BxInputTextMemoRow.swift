/**
 *	@file BxInputTextMemoRow.swift
 *	@namespace BxInputController
 *
 *	@details Row for putting big text string
 *	@date 01.08.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Row for putting big text string
open class BxInputTextMemoRow: BxInputTextRow, BxInputStaticHeight, BxInputTextMemoRowProtocol
{
    
    /// Make and return Binder for binding row with cell.
    override open var binder : BxInputRowBinder {
        return BxInputTextMemoRowBinder<BxInputTextMemoRow, BxInputTextMemoCell>(row: self)
    }
    
    override open var resourceId : String {
        get { return "BxInputTextMemoCell" }
    }
    
    open var height : CGFloat = 120
    override open var estimatedHeight : CGFloat {
        get { return height }
    }
    
}
