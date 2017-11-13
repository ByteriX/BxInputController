/**
 *	@file BxInputDateRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputDateRow subclasses
 *	@date 17.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputDateRow subclasses
open class BxInputDateRowBinder<Row : BxInputDateRow, Cell>: BxInputStandartTextRowBinder<Row, Cell>
where Cell : UITableViewCell, Cell : BxInputFieldCell
{
    /// call after common update for text attributes updating
    override open func updateCell()
    {
        super.updateCell()
        if let date = row.value {
            cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
        } else {
            cell?.valueTextField.text = ""
        }
    }
    
    /// event when value is changed
    override open func valueChanged(valueTextField: UITextField) {
        // date value changed from 'editedDate()' method
    }
    
    @objc func changeDate() {
        guard let date = owner?.datePicker.date else {
            return
        }
        cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
        row.value = date
    }
    
    /// event when value is changed if value have date type
    @objc func editedDate() {
        changeDate()
        didChangedValue(for: row)
    }
    
    /// start editing
    override open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if super.textFieldShouldBeginEditing(textField),
            let datePicker = owner?.datePicker
        {
            datePicker.addTarget(self, action: #selector(editedDate), for: [.valueChanged, .touchUpInside])
            cell?.valueTextField.inputView = datePicker
            datePicker.minimumDate = row.minimumDate
            datePicker.maximumDate = row.maximumDate
            if let date = row.value {
                datePicker.date = date
                changeDate()
            } else {
                datePicker.date = Date()
                editedDate()
            }
            
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
