/**
 *	@file BxInputVariantsRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputVariantsRow
 *	@date 17.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputVariantsRow
open class BxInputVariantsRowBinder<T : BxInputStringObject, Cell>: BxInputStandartTextRowBinder<BxInputVariantsRow<T>, Cell>, UIPickerViewDelegate, UIPickerViewDataSource
where Cell : UITableViewCell, Cell : BxInputFieldCell
{
    /// call after common update for text attributes updating
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
            var index: Int? = nil
            if let value = row.selectedVariant {
                if let foundIndex = row.variants.index(where: { (item) -> Bool in
                    return item === value
                }) {
                    index = foundIndex
                }
            }
            if let index = index {
                variantsPicker.selectRow(index, inComponent: 0, animated: true)
                changeValue(index: index)
            } else {
                variantsPicker.selectRow(0, inComponent: 0, animated: true)
                self.pickerView(variantsPicker, didSelectRow: 0, inComponent: 0)
            }
            cell?.valueTextField.inputView = variantsPicker
        } else {
            return false
        }
        
        return true
    }
    
    func changeValue(index: Int) {
        let value = row.variants[index]
        self.row.selectedVariant = value
        cell?.valueTextField.text = value.stringValue
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
        changeValue(index: row)
        didChangedValue(for: self.row)
    }

}
