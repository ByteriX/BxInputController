/**
 *	@file BxInputSelectorDateRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputSelectorDateRow subclasses (parent selector)
 *	@date 17.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputSelectorDateRow subclasses (parent selector)
open class BxInputSelectorDateRowBinder<Row: BxInputSelectorDateRow, Cell: BxInputSelectorCell>: BxInputSelectorRowBinder<Row, Cell>, BxInputRowBinderMenuAll
{
    
    /// visual updating of value && separator that depends on type of the row
    override open func checkValue() {
        super.checkValue()
        if let date = row.value {
            cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
        } else {
            cell?.valueTextField.text = ""
        }
    }
    
    open func copyValue() {
        if let date = row.value {
            UIPasteboard.general.string = owner?.settings.dateFormat.string(from: date)
        } else {
            UIPasteboard.general.string = ""
        }
    }
    
    open func pasteValue() {
        if let string = UIPasteboard.general.string, let date = owner?.settings.dateFormat.date(from: string) {
            row.value = date
            update()
            didChangeValue()
            if row.isOpened {
                if let child = owner?.getRowBinder(for: row.child) as? BxInputChildSelectorDateRowBinder {
                    child.updateDate(animated: true)
                }
            }
        }
    }
    
    open func deleteValue() {
        row.value = nil
        update()
        didChangeValue()
        toClose()
    }
    
}
