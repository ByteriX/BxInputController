//
//  BxInputSearchVariantRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 10/01/2019.
//  Copyright © 2019 Byterix. All rights reserved.
//

import UIKit

open class BxInputSearchVariantRowBinder<T: BxInputStringObject, Row: BxInputSearchVariantRow<T>, Cell: BxInputSelectorCell>: BxInputSelectorVariantRowBinder<T, Row, Cell>, UITextFieldDelegate
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
            if let parentRowBinder = owner?.getRowBinder(for: row.child) as? BxInputChildSelectorVariantRowBinder<T> {
                parentRowBinder.updateItems()
                if row.isOnlyOneAutoselect && row.items.count == 1 && row.value !== row.items.first {
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

    override open func didResetItems() {
        super.didResetItems()
        if let valueTextField = cell?.valueTextField {
            valueTextField.resignFirstResponder()
            valueChanged(valueTextField: valueTextField)
        }
    }

    override public func searchValue(_ string: String) -> T? {
        if let valueTextField = cell?.valueTextField {
            valueTextField.text = string
            valueChanged(valueTextField: valueTextField)
        }
        return row.items.first(where: { return $0.stringValue == string })
    }
    
}
