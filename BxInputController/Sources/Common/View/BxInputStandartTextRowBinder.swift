//
//  BxInputStandartTextRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputStandartTextRowBinder<Row: BxInputRow, Cell: BxInputStandartTextCell> : BxInputBaseRowBinder<Row, Cell>, BxInputStandartTextDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    override open func didSelected()
    {
        super.didSelected()
        
        if let checkRow = row as? BxInputCheckRow {
            owner?.dissmissAllRows()
            checkRow.value = !checkRow.value
            update()
        } else {
            cell?.valueTextField.becomeFirstResponder()
        }
        
    }
    
    open func updateCell() {
        cell?.valueTextField.isEnabled = true
        cell?.accessoryType = .none
        cell?.selectionStyle = .none
    }
    
    override open func update()
    {
        super.update()
        cell?.delegate = self
        //
        cell?.titleLabel.font = owner?.settings.titleFont
        cell?.titleLabel.textColor = owner?.settings.titleColor
        cell?.valueTextField.font = owner?.settings.valueFont
        cell?.valueTextField.textColor = owner?.settings.valueColor
        //
        cell?.titleLabel.text = row.title
        
        // reset cell for reuse subclass
        cell?.valueTextField.isSecureTextEntry = false
        
        if let placeholder = row.placeholder,
            let placeholderColor = owner?.settings.placeholderColor
        {
            cell?.valueTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : placeholderColor])
        } else {
            cell?.valueTextField.placeholder = row.placeholder
        }
        
        updateCell()
        
        
        if let checkRow = row as? BxInputCheckRow {
            cell?.valueTextField.isEnabled = false
            cell?.valueTextField.text = ""
            cell?.accessoryType = checkRow.value ? .checkmark : .none
            cell?.selectionStyle = .default
        } else {
            
        }
        if let textRow = row as? BxInputTextRow {
            cell?.valueTextField.inputView = nil
            cell?.valueTextField.text = textRow.value
            cell?.valueTextField.update(from: textRow)
        }
        if let dateRow = row as? BxInputDateRow {
            if let date = dateRow.value {
                cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
            } else {
                cell?.valueTextField.text = ""
            }
        } else if let variantsRow = row as? BxInputVariants {
            if let value = variantsRow.selectedVariant {
                cell?.valueTextField.text = value.stringValue
            } else {
                cell?.valueTextField.text = ""
            }
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
    open func valueChanged(valueTextField: UITextField) {
        if let textRow = row as? BxInputTextRow {
            textRow.value = cell?.valueTextField.text
            owner?.didChangedRow(textRow)
        } else if let _ = row as? BxInputDateRow {
            // date value changed from 'changeDate()' method
        }
    }
    
    /// event when value is changed if value have date type
    func changeDate() {
        guard let date = owner?.datePicker.date else {
            return
        }
        cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
        if let dateRow = row as? BxInputDateRow
        {
            dateRow.value = date
            owner?.didChangedRow(dateRow)
        }
    }
    
    // MARK - UITextFieldDelegate delegates
    
    
    /// start editing
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if !isEnabled {
            return false
        }
        if let dateRow = row as? BxInputDateRow,
            let datePicker = owner?.datePicker
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
        } else if let variantsRow = row as? BxInputVariants,
            let variantsPicker = owner?.variantsPicker
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
        if let owner = owner, owner.settings.isAutodissmissSelector {
            owner.dissmissSelectors()
        }
        owner?.activeRow = row
        owner?.activeControl = textField
        return true
    }
    
    /// end editing
    open func textFieldDidEndEditing(_ textField: UITextField)
    {
        if let datePicker = owner?.datePicker
        {
            datePicker.removeTarget(self, action: #selector(changeDate), for: [.valueChanged, .touchUpInside])
        }
        if owner?.activeControl === textField {
            owner?.activeControl = nil
        }
        if owner?.activeRow === row {
            owner?.activeRow = nil
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
        if let _ = row as? BxInputTextRow { // counting
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
        guard let variantsRow = row as? BxInputVariants else {
            return 0
        }
        return variantsRow.variants.count
    }
    
    /// variant title
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let variantsRow = self.row as? BxInputVariants else {
            return nil
        }
        return variantsRow.variants[row].stringValue
    }
    
    /// event when user choose variant
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        guard var variantsRow = self.row as? BxInputVariants
            else {
                return
        }
        let value = variantsRow.variants[row]
        variantsRow.selectedVariant = value
        cell?.valueTextField.text = value.stringValue
        owner?.didChangedRow(self.row)
    }
    
    
}
