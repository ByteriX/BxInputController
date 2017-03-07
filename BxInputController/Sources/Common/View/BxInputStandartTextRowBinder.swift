//
//  BxInputStandartTextRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputStandartTextRowBinder<Row: BxInputRow, Cell: BxInputStandartTextCell> : BxInputBaseRowBinder<Row, Cell>, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    override open func didSelected()
    {
        super.didSelected()
        
        if let actionRow = data as? BxInputActionRow
        {
            if let parent = parent, parent.settings.isAutodissmissSelector {
                parent.dissmissAllRows()
            }
            if let handler = actionRow.handler {
                handler(actionRow)
            }
        } else if let checkRow = data as? BxInputCheckRow {
            parent?.dissmissAllRows()
            checkRow.value = !checkRow.value
            update()
        } else {
            cell?.valueTextField.becomeFirstResponder()
        }
        
    }
    
    override open func update()
    {
        super.update()
        cell?.valueTextField.delegate = self
        //
        cell?.titleLabel.font = parent?.settings.titleFont
        cell?.titleLabel.textColor = parent?.settings.titleColor
        cell?.valueTextField.font = parent?.settings.valueFont
        cell?.valueTextField.textColor = parent?.settings.valueColor
        //
        cell?.titleLabel.text = data.title
        
        if let actionRow = data as? BxInputActionRow {
            cell?.valueTextField.isEnabled = false
            cell?.valueTextField.text = actionRow.stringValue // may be all values rewrite to stringValue
            cell?.accessoryType = .disclosureIndicator
            cell?.selectionStyle = .default
        } else if let checkRow = data as? BxInputCheckRow {
            cell?.valueTextField.isEnabled = false
            cell?.valueTextField.text = ""
            cell?.accessoryType = checkRow.value ? .checkmark : .none
            cell?.selectionStyle = .default
        } else {
            cell?.valueTextField.isEnabled = true
            cell?.accessoryType = .none
            cell?.selectionStyle = .none
        }
        if let textRow = data as? BxInputTextRow {
            cell?.valueTextField.inputView = nil
            cell?.valueTextField.text = textRow.value
            cell?.valueTextField.update(from: textRow)
        } else {
            cell?.valueTextField.isSecureTextEntry = false
        }
        if let dateRow = data as? BxInputDateRow {
            if let date = dateRow.value {
                cell?.valueTextField.text = parent?.settings.dateFormat.string(from: date)
            } else {
                cell?.valueTextField.text = ""
            }
        } else if let variantsRow = data as? BxInputVariants {
            if let value = variantsRow.selectedVariant {
                cell?.valueTextField.text = value.stringValue
            } else {
                cell?.valueTextField.text = ""
            }
        }
        if let placeholder = data.placeholder,
            let placeholderColor = parent?.settings.placeholderColor
        {
            cell?.valueTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : placeholderColor])
        } else {
            cell?.valueTextField.placeholder = data.placeholder
        }
        
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.valueTextField.isEnabled = value
        cell?.valueTextField.alpha = value ? 1 : 0.5
        cell?.titleLabel.alpha = value ? 1 : 0.5
    }
    
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        return cell?.valueTextField.resignFirstResponder() ?? false
    }
    
    /// event when value is changed
    @IBAction func valueTextFieldEditingChanged(_ sender: Any) {
        if let textRow = data as? BxInputTextRow {
            textRow.value = cell?.valueTextField.text
            parent?.didChangedRow(textRow)
        } else if let _ = data as? BxInputDateRow {
            // date value changed from 'changeDate()' method
        }
    }
    
    /// event when value is changed if value have date type
    func changeDate() {
        guard let date = parent?.datePicker.date else {
            return
        }
        cell?.valueTextField.text = parent?.settings.dateFormat.string(from: date)
        if let dateRow = data as? BxInputDateRow
        {
            dateRow.value = date
            parent?.didChangedRow(dateRow)
        }
    }
    
    // MARK - UITextFieldDelegate delegates
    
    
    /// start editing
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if !isEnabled {
            return false
        }
        if let dateRow = data as? BxInputDateRow,
            let datePicker = parent?.datePicker
        {
            datePicker.addTarget(self, action: #selector(changeDate), for: [.valueChanged, .touchUpInside])
            cell?.valueTextField.inputView = datePicker
            datePicker.minimumDate = dateRow.minimumDate
            datePicker.maximumDate = dateRow.maximumDate
            if let date = dateRow.value {
                datePicker.date = date
            } else {
                datePicker.date = Date()
            }
            changeDate()
        } else if let variantsRow = data as? BxInputVariants,
            let variantsPicker = parent?.variantsPicker
        {
            variantsPicker.dataSource = self
            variantsPicker.delegate = self
            variantsPicker.reloadAllComponents()
            var index = 0
            if let value = variantsRow.selectedVariant {
                if let foundIndex = variantsRow.variants.index(where: { (item) -> Bool in
                    return item === value
                }) {
                    index = foundIndex
                }
            }
            variantsPicker.selectRow(index, inComponent: 0, animated: true)
            self.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
            cell?.valueTextField.inputView = variantsPicker
        }
        if let parent = parent, parent.settings.isAutodissmissSelector {
            parent.dissmissSelectors()
        }
        parent?.activeRow = data
        parent?.activeControl = textField
        return true
    }
    
    /// end editing
    open func textFieldDidEndEditing(_ textField: UITextField)
    {
        if let datePicker = parent?.datePicker
        {
            datePicker.removeTarget(self, action: #selector(changeDate), for: [.valueChanged, .touchUpInside])
        }
        if parent?.activeControl === textField {
            parent?.activeControl = nil
        }
        if parent?.activeRow === data {
            parent?.activeRow = nil
        }
    }
    
    /// changing value event for correct showing
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if let text = textField.text,
            range.location == text.characters.count && string == " "
        {
            textField.text = text + "\u{00a0}"
            return false
        }
        if let _ = data as? BxInputTextRow { // counting
            // not yet implemented
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
    
    
    // MARK - UIPickerViewDelegate, UIPickerViewDataSource delegates
    
    /// only single
    open func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    /// variants count
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        guard let variantsRow = data as? BxInputVariants else {
            return 0
        }
        return variantsRow.variants.count
    }
    
    /// variant title
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let variantsRow = data as? BxInputVariants else {
            return nil
        }
        return variantsRow.variants[row].stringValue
    }
    
    /// event when user choose variant
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        guard var variantsRow = data as? BxInputVariants
            else {
                return
        }
        let value = variantsRow.variants[row]
        variantsRow.selectedVariant = value
        cell?.valueTextField.text = value.stringValue
        parent?.didChangedRow(data)
    }
    
    
}
