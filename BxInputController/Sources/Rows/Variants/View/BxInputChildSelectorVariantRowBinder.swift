/**
 *	@file BxInputChildSelectorVariantRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputChildSelectorVariantRow
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputChildSelectorVariantRow
open class BxInputChildSelectorVariantRowBinder<T: BxInputStringObject> : BxInputChildSelectorRowBinder<BxInputChildSelectorVariantRow<T>, BxInputChildSelectorVariantCell, BxInputSelectorVariantRow<T>>, BxInputChildSelectorVariantDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    /// update cell from model data
    override open func update()
    {
        super.update()
        cell?.delegate = self
        updateItems()
        var index: Int? = nil
        if let value = parentRow.selectedVariant {
            if let foundIndex = parentRow.variants.firstIndex(where: { (item) -> Bool in
                return item === value
            }) {
                index = foundIndex
            }
        }
        
        DispatchQueue.main.async { [weak cell, weak self] () -> Void in
            if let variantPicker = cell?.variantPicker {
                if let index = index {
                    variantPicker.selectRow(index, inComponent: 0, animated: true)
                    self?.changeValue(index: index)
                } else {
                    if self?.parentRow.isFirstShownSelect ?? false {
                        self?.selectValue(from: 0)
                    }
                }
            }
        }
    }
    
    /// select first value
    internal func selectValue(from index: Int) {
        if let variantPicker = cell?.variantPicker {
            variantPicker.selectRow(index, inComponent: 0, animated: true)
            pickerView(variantPicker, didSelectRow: index, inComponent: 0)
        }
    }
    
    /// update items showing
    internal func updateItems() {
        cell?.variantPicker.reloadAllComponents()
    }
    
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        cell.variantPicker.isUserInteractionEnabled = value
        // UI part
        if needChangeDisabledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.variantPicker, isEnabled)
            } else {
                cell.variantPicker.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.variantPicker.alpha = 1
        }
    }
    
    func changeValue(index: Int) {
        guard index < parentRow.variants.count else {
            return
        }
        let value = parentRow.variants[index]
        parentRow.selectedVariant = value
        owner?.updateRow(parentRow)
    }
    
    // MARK - UIPickerViewDelegate, UIPickerViewDataSource
    
    /// only single
    open func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    /// variants count
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        guard let variantRow = row.parent as? BxInputVariant else
        {
            return 0
        }
        return variantRow.variants.count
    }
    
    /// variant title
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let variantRow = self.row.parent as? BxInputVariant
            else {
                return nil
        }
        return variantRow.variants[row].stringValue
    }
    
    /// event when user choose variant
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        changeValue(index: row)
        parentRowBinder.didChangeValue()
        tryToClose()
    }
    
}
