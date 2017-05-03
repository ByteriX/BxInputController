/**
 *	@file BxInputTextRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputTextRow subclasses
 *	@date 17.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputTextRow subclasses
open class BxInputTextRowBinder<Row : BxInputTextRow, Cell : BxInputStandartTextCell>: BxInputStandartTextRowBinder<Row, Cell>
{
    /// call after common update for text attributes updating
    override open func updateCell()
    {
        super.updateCell()
        
        cell?.valueTextField.inputView = nil
        cell?.valueTextField.text = row.value
        cell?.valueTextField.update(from: row)
    }
    
    /// changing value event for correct showing
    override open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        // not yet implemented couting
        return super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    
    /// event when value is changed
    override open func valueChanged(valueTextField: UITextField) {
        super.valueChanged(valueTextField: valueTextField)
        row.value = cell?.valueTextField.text
        didChangedValue(for: row)
    }
}