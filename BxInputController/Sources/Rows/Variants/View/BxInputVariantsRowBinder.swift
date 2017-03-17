//
//  BxInputVariantsRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 17/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputVariantsRowBinder<T : BxInputStringObject, Cell : BxInputStandartTextCell>: BxInputStandartTextRowBinder<BxInputVariantsRow<T>, Cell>, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    override open func updateCell()
    {
        super.updateCell()
        
        if let value = row.selectedVariant {
            cell?.valueTextField.text = value.stringValue
        } else {
            cell?.valueTextField.text = ""
        }
    }
    
    /// start editing
    override open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if super.textFieldShouldBeginEditing(textField),
            let variantsPicker = owner?.variantsPicker
        {
            variantsPicker.dataSource = self
            variantsPicker.delegate = self
            variantsPicker.reloadAllComponents()
            var index = 0
            if let value = row.selectedVariant {
                if let foundIndex = row.variants.index(where: { (item) -> Bool in
                    return item === value
                }) {
                    index = foundIndex
                }
            }
            variantsPicker.selectRow(index, inComponent: 0, animated: true)
            self.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
            cell?.valueTextField.inputView = variantsPicker
        } else {
            return false
        }
        
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
        return row.variants.count
    }
    
    /// variant title
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.row.variants[row].stringValue
    }
    
    /// event when user choose variant
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let value = self.row.variants[row]
        self.row.selectedVariant = value
        cell?.valueTextField.text = value.stringValue
        owner?.didChangedRow(self.row)
    }

}
