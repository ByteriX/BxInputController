//
//  BxInputSelectorVariantsRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorVariantsRowBinder<Row: BxInputChildSelectorVariantsRow, Cell: BxInputSelectorVariantsCell> : BxInputBaseRowBinder<Row, Cell>, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    override open func update()
    {
        super.update()
        cell?.variantsPicker.dataSource = self
        cell?.variantsPicker.delegate = self
        if let parentRow = data.parent as? BxInputVariants
        {
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
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.variantsPicker.isUserInteractionEnabled = value
        cell?.variantsPicker.alpha = value ? 1.0 : 0.5
    }
    
    open func autoselection() {
        if let parentRow = data.parent
        {
            if parentRow.isOpened {
                parentRow.isOpened = false
                parent?.deleteRow(row)
                parent?.updateRow(parentRow)
            }
        }
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
        guard let parentRow = data.parent,
            var variantsRow = parentRow as? BxInputVariants
        else {
            return
        }
        let value = variantsRow.variants[row]
        
        variantsRow.selectedVariant = value
        parent?.updateRow(parentRow)
        parent?.didChangedRow(parentRow)
        
        if parentRow.timeForAutoselection > 0.499 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoselection), object: nil)
            self.perform(#selector(autoselection), with: nil, afterDelay: parentRow.timeForAutoselection)
        }
    }
    
}
