//
//  BxInputSelectorVariantsRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorVariantsRowBinder<T: BxInputStringObject> : BxInputChildSelectorRowBinder<BxInputChildSelectorVariantsRow<T>, BxInputSelectorVariantsCell, BxInputSelectorVariantsRow<T>>, BxInputSelectorVariantsDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    override open func update()
    {
        super.update()
        cell?.delegate = self
            cell?.variantsPicker.reloadAllComponents()
            var index = 0
            if let value = parentData.selectedVariant {
                if let foundIndex = parentData.variants.index(where: { (item) -> Bool in
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
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.variantsPicker.isUserInteractionEnabled = value
        cell?.variantsPicker.alpha = value ? 1.0 : 0.5
    }
    
    // MARK - UIPickerViewDelegate, UIPickerViewDataSource
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        guard let variantsRow = data.parent as? BxInputVariants else
        {
            return 0
        }
        return variantsRow.variants.count
    }
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let variantsRow = data.parent as? BxInputVariants
            else {
                return nil
        }
        return variantsRow.variants[row].stringValue
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let value = parentData.variants[row]
        
        parentData.selectedVariant = value
        parent?.updateRow(parentData)
        parent?.didChangedRow(parentData)
        
        tryToClose()
    }
    
}
