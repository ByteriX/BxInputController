//
//  BxInputDateRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 17/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputDateRowBinder<Row : BxInputDateRow, Cell : BxInputStandartTextCell>: BxInputStandartTextRowBinder<Row, Cell>
{
    
    override open func updateCell()
    {
        super.updateCell()
        if let date = row.value {
            cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
        } else {
            cell?.valueTextField.text = ""
        }
    }
    
    /// event when value is changed if value have date type
    func changeDate() {
        guard let date = owner?.datePicker.date else {
            return
        }
        cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
        row.value = date
        owner?.didChangedRow(row)
    }
    
    /// start editing
    override open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if super.textFieldShouldBeginEditing(textField),
            let datePicker = owner?.datePicker
        {
            datePicker.addTarget(self, action: #selector(changeDate), for: [.valueChanged, .touchUpInside])
            cell?.valueTextField.inputView = datePicker
            datePicker.minimumDate = row.minimumDate
            datePicker.maximumDate = row.maximumDate
            if let date = row.value {
                datePicker.date = date
            } else {
                datePicker.date = Date()
            }
            changeDate()
        } else {
            return false
        }
        
        return true
    }
    
    /// end editing
    override open func textFieldDidEndEditing(_ textField: UITextField)
    {
        super.textFieldDidEndEditing(textField)
        if let datePicker = owner?.datePicker
        {
            datePicker.removeTarget(self, action: #selector(changeDate), for: [.valueChanged, .touchUpInside])
        }
    }
    
    
}
