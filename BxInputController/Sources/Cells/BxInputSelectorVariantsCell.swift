//
//  BxInputSelectorVariantsCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputSelectorVariantsCell: BxInputStandartCell {

    @IBOutlet weak var variantsPicker: UIPickerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        if let row = data as? BxInputChildSelectorVariantsRow,
            let parentRow = row.parent as? BxInputSelectorVariantsRow
        {
            variantsPicker.reloadAllComponents()
            var index = 0
            if let value = parentRow.value {
                if let foundIndex = parentRow.items.index(where: { (item) -> Bool in
                    return item === value
                }) {
                    index = foundIndex
                }
            }
            variantsPicker.selectRow(index, inComponent: 0, animated: true)
            self.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
        }
    }
    
    func autoselection() {
        if let row = data as? BxInputChildSelectorVariantsRow,
            let parentRow = row.parent as? BxInputSelectorVariantsRow
        {
            if parentRow.isOpened {
                parentRow.isOpened = false
                parent?.deleteRow(row)
                parent?.updateRow(parentRow)
            }
        }
    }
    
}

extension BxInputSelectorVariantsCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        guard let currentRow = data as? BxInputChildSelectorVariantsRow,
            let variantsRow = currentRow.parent as? BxInputSelectorVariantsRow else
        {
            return 0
        }
        return variantsRow.items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        guard let currentRow = data as? BxInputChildSelectorVariantsRow,
            let variantsRow = currentRow.parent as? BxInputSelectorVariantsRow
        else {
            return nil
        }
        return variantsRow.items[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        guard let currentRow = data as? BxInputChildSelectorVariantsRow,
            let parentRow = currentRow.parent as? BxInputSelectorVariantsRow
        else {
            return
        }
        let value = parentRow.items[row]
        parentRow.value = value
        
        parent?.updateRow(parentRow)
        if parentRow.timeForAutoselection > 0.499 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoselection), object: nil)
            self.perform(#selector(autoselection), with: nil, afterDelay: parentRow.timeForAutoselection)
        }
    }
    
}
