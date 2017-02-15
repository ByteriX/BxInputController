/**
 *	@file BxInputSelectorVariantsCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for showing variant selector as data picker
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Cell for showing variant selector as data picker
open class BxInputSelectorVariantsCell: BxInputBaseCell {

    @IBOutlet weak open var variantsPicker: UIPickerView!
    
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        if let row = data as? BxInputChildSelectorVariantsRow,
            let parentRow = row.parent as? BxInputVariants
        {
            variantsPicker.reloadAllComponents()
            var index = 0
            if let value = parentRow.selectedVariant {
                if let foundIndex = parentRow.variants.index(where: { (item) -> Bool in
                    return item === value
                }) {
                    index = foundIndex
                }
            }
            variantsPicker.selectRow(index, inComponent: 0, animated: true)
            
            DispatchQueue.main.async { [weak self] () -> Void in
                if let variantsPicker = self?.variantsPicker {
                    self?.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
                }
            }
        }
    }
    
    open func autoselection() {
        if let row = data as? BxInputChildSelectorVariantsRow,
            let parentRow = row.parent
        {
            if parentRow.isOpened {
                parentRow.isOpened = false
                parent?.deleteRow(row)
                parent?.updateRow(parentRow)
            }
        }
    }
    
}

/// Implementation UIPickerViewDelegate, UIPickerViewDataSource for BxInputSelectorVariantsCell
extension BxInputSelectorVariantsCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        guard let currentRow = data as? BxInputChildSelectorVariantsRow,
            let variantsRow = currentRow.parent as? BxInputVariants else
        {
            return 0
        }
        return variantsRow.variants.count
    }
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let currentRow = data as? BxInputChildSelectorVariantsRow,
            let variantsRow = currentRow.parent as? BxInputVariants
        else {
            return nil
        }
        return variantsRow.variants[row].stringValue
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        guard let currentRow = data as? BxInputChildSelectorVariantsRow,
            let parentRow = currentRow.parent,
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
