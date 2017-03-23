/**
 *	@file BxInputChildSelectorVariantsRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputChildSelectorVariantsRow
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputChildSelectorVariantsRow
open class BxInputChildSelectorVariantsRowBinder<T: BxInputStringObject> : BxInputChildSelectorRowBinder<BxInputChildSelectorVariantsRow<T>, BxInputChildSelectorVariantsCell, BxInputSelectorVariantsRow<T>>, BxInputChildSelectorVariantsDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    /// update cell from model data
    override open func update()
    {
        super.update()
        cell?.delegate = self
        cell?.variantsPicker.reloadAllComponents()
        var index = 0
        if let value = parentRow.selectedVariant {
            if let foundIndex = parentRow.variants.index(where: { (item) -> Bool in
                return item === value
            }) {
                index = foundIndex
            }
        }
        cell?.variantsPicker.selectRow(index, inComponent: 0, animated: true)
        
        DispatchQueue.main.async { [weak cell, weak self] () -> Void in
            if let variantsPicker = cell?.variantsPicker {
                self?.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
            }
        }
    }
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.variantsPicker.isUserInteractionEnabled = value
        cell?.variantsPicker.alpha = value ? 1.0 : 0.5
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
        guard let variantsRow = row.parent as? BxInputVariants else
        {
            return 0
        }
        return variantsRow.variants.count
    }
    
    /// variant title
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let variantsRow = self.row.parent as? BxInputVariants
            else {
                return nil
        }
        return variantsRow.variants[row].stringValue
    }
    
    /// event when user choose variant
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let value = parentRow.variants[row]
        
        parentRow.selectedVariant = value
        owner?.updateRow(parentRow)
        didChangedValue(for: parentRow)
        
        tryToClose()
    }
    
}
