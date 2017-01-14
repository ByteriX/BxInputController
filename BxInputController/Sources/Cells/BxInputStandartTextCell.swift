//
//  BxInputStandartTextCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputStandartTextCell: BxInputStandartCell {
    
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var valueTextField: UITextField!

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override open func didSelected()
    {
        super.didSelected()
        if data?.isEnabled ?? true {
            if let actionRow = data as? BxInputActionRow
            {
                if let handler = actionRow.handler {
                    handler(actionRow)
                }
            } else {
                valueTextField.becomeFirstResponder()
            }
            
        }
    }
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        titleLabel.font = parent?.settings.titleFont
        titleLabel.textColor = parent?.settings.titleColor
        valueTextField.font = parent?.settings.valueFont
        valueTextField.textColor = parent?.settings.valueColor
        //
        titleLabel.text = data.title
        
        if let actionRow = data as? BxInputActionRow {
            valueTextField.isEnabled = false
            valueTextField.text = actionRow.value // may be all values rewrite to stringValue
            self.accessoryType = .disclosureIndicator
            self.selectionStyle = .default
        } else {
            valueTextField.isEnabled = true
            self.accessoryType = .none
            self.selectionStyle = .none
        }
        if let textRow = data as? BxInputTextRow {
            valueTextField.inputView = nil
            valueTextField.text = textRow.value
            valueTextField.update(from: textRow)
        } else {
            valueTextField.isSecureTextEntry = false
        }
        if let dateRow = data as? BxInputDateRow {
            if let date = dateRow.value {
                valueTextField.text = parent?.settings.dateFormat.string(from: date)
            } else {
                valueTextField.text = ""
            }
        } else if let variantsRow = data as? BxInputVariantsRow {
            if let value = variantsRow.value {
                valueTextField.text = value.name
            } else {
                valueTextField.text = ""
            }
        }
        valueTextField.placeholder = data.placeholder
    }
    
    override open func resignFirstResponder() -> Bool {
        return valueTextField.resignFirstResponder()
    }
    
    @IBAction func valueTextFieldEditingChanged(_ sender: Any) {
        if let textRow = data as? BxInputTextRow {
            textRow.value = valueTextField.text
        } else if let dateRow = data as? BxInputDateRow {
            //
        }
    }
    
    func changeDate() {
        guard let date = parent?.datePicker.date else {
            return
        }
        valueTextField.text = parent?.settings.dateFormat.string(from: date)
        if let dateRow = data as? BxInputDateRow
        {
            dateRow.value = date
        }
    }
}


extension BxInputStandartTextCell: UITextFieldDelegate {
    
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if let dateRow = data as? BxInputDateRow,
            let datePicker = parent?.datePicker
        {
            datePicker.addTarget(self, action: #selector(changeDate), for: [.valueChanged, .touchUpInside])
            valueTextField.inputView = datePicker
            datePicker.minimumDate = dateRow.minimumDate
            datePicker.maximumDate = dateRow.maximumDate
            if let date = dateRow.value {
                datePicker.date = date
            } else {
                datePicker.date = Date()
            }
        } else if let variantsRow = data as? BxInputVariantsRow,
            let variantsPicker = parent?.variantsPicker
        {
            variantsPicker.dataSource = self
            variantsPicker.delegate = self
            variantsPicker.reloadAllComponents()
            var index = 0
            if let value = variantsRow.value {
                if let foundIndex = variantsRow.items.index(where: { (item) -> Bool in
                    return item === value
                }) {
                    index = foundIndex
                }
            }
            variantsPicker.selectRow(index, inComponent: 0, animated: true)
            self.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
            valueTextField.inputView = variantsPicker
        }
        if parent?.settings.isAutodissmissSelector ?? false {
            parent?.dissmissAllRows(exclude: data)
        }
        parent?.activeControl = textField
        return true
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField)
    {
        if let datePicker = parent?.datePicker
        {
            datePicker.removeTarget(self, action: #selector(changeDate), for: [.valueChanged, .touchUpInside])
        }
        if parent?.activeControl === textField {
            parent?.activeControl = nil
        }
    }

    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if let text = textField.text,
            range.location == text.characters.count && string == " "
        {
            textField.text = text + "\u{00a0}"
            return false
        }
        if let data = data as? BxInputTextRow { // counting
            //
        }
        return true
    }


    open func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        textField.text = ""
        return true
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}


extension BxInputStandartTextCell: UIPickerViewDelegate, UIPickerViewDataSource {

    open func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    

    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        guard let variantsRow = data as? BxInputVariantsRow else {
            return 0
        }
        return variantsRow.items.count
    }
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let variantsRow = data as? BxInputVariantsRow else {
            return nil
        }
        return variantsRow.items[row].name
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        guard let variantsRow = data as? BxInputVariantsRow else {
            return
        }
        let value = variantsRow.items[row]
        variantsRow.value = value
        valueTextField.text = value.name
    }

}

