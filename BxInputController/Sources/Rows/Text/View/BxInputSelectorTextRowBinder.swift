/**
 *	@file BxInputSelectorTextRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputSelectorTextRow subclasses
 *	@date 17.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputSelectorTextRow subclasses
open class BxInputSelectorTextRowBinder<Row: BxInputSelectorTextRow, Cell: BxInputSelectorCell>: BxInputSelectorRowBinder<Row, Cell>
{
    
    /// visual updating of value && separator that depends on type of the row
    override open func checkValue() {
        super.checkValue()
        // changing for BxInputSelectorTextRow
        var separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        if let settings = owner?.settings {
            separatorInset = settings.separatorInset
        }
        if row.isOpened {
            separatorInset.left = cell?.frame.size.width ?? 16
            // for hide in selector text when row is opened
            cell?.valueTextField.text = ""
        }
        cell?.separatorInset = separatorInset
    }
    
}
