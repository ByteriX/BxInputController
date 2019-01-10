//
//  BxInputSearchVariantsRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/2019.
//  Copyright © 2019 Byterix. All rights reserved.
//

import UIKit

open class BxInputSearchVariantsRowBinder<T: BxInputStringObject, Row: BxInputSearchVariantsRow<T>, Cell: BxInputSelectorCell>: BxInputSelectorVariantsRowBinder<T, Row, Cell>, UITextFieldDelegate
{
    
    override open func update() {
        super.update()
        //
        cell?.valueTextField.changeTarget(self, action: #selector(valueChanged(valueTextField:)), for: .editingChanged)
        cell?.valueTextField.delegate = self
        cell?.valueTextField.update(from: BxInputTextSettings.standart)
    }
    
    override open func didSelected()
    {
        super.didSelected()
        if row.isEnabled {
            if row.isOpened {
                cell?.valueTextField.isUserInteractionEnabled = true
                cell?.valueTextField.becomeFirstResponder()
            } else {
                cell?.valueTextField.resignFirstResponder()
                cell?.valueTextField.isUserInteractionEnabled = false
            }
        }
    }

    /// event when value is changed. Need reload this in inherited classes
    @objc open func valueChanged(valueTextField: UITextField) {
        if let searchHandler = row.searchHandler {
            if let text = valueTextField.text {
                row.items = searchHandler(row, text)
            } else {
                row.items = []
            }
            if let parentRowBinder = owner?.getRowBinder(for: row.child) as? BxInputChildSelectorVariantsRowBinder<T> {
                parentRowBinder.updateItems()
                if row.items.count == 1 && row.value !== row.items.first {
                    parentRowBinder.selectValue(from: 0)
                }
            }
        }
    }
    
    /// changing value event for correct showing
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if let text = textField.text,
            range.location == text.chars.count && string == " "
        {
            textField.text = text + "\u{00a0}"
            return false
        }
        return true
    }
    
    /// clear event, when user click clear button
    open func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        textField.text = ""
        return true
    }
    
    /// user click Done
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
}
