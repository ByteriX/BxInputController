//
//  BxInputTextRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 17/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputTextRowBinder<Row : BxInputTextRow, Cell : BxInputStandartTextCell>: BxInputStandartTextRowBinder<Row, Cell>
{
    
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
        owner?.didChangedRow(row)
    }
}
