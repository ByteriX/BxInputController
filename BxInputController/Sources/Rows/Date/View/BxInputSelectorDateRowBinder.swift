//
//  BxInputSelectorDateRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorDateRowBinder<Row: BxInputChildSelectorDateRow, Cell: BxInputSelectorDateCell> : BxInputBaseRowBinder<Row, Cell>, BxInputSelectorDateDelegate
{
    
    override open func update()
    {
        super.update()
        guard let cell = cell else {
            return
        }
        cell.delegate = self
        if let parentRow = data.parent as? BxInputSelectorDateRow
        {
            cell.datePicker.minimumDate = parentRow.minimumDate
            cell.datePicker.maximumDate = parentRow.maximumDate
            if let date = parentRow.value {
                cell.datePicker.setDate(date, animated: false)
            } else {
                cell.datePicker.setDate(Date(), animated: false)
            }
        }
        DispatchQueue.main.async { [weak self, weak cell] () -> Void in
            if let datePicker = cell?.datePicker {
                self?.changeDate(datePicker: datePicker)
            }
        }
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.datePicker.isEnabled = value
        cell?.datePicker.isUserInteractionEnabled = value
        cell?.datePicker.alpha = value ? 1.0 : 0.5
    }
    
    open func changeDate(datePicker: UIDatePicker) {
        if let parentRow = data.parent as? BxInputSelectorDateRow
        {
            parentRow.value = cell?.datePicker.date
            parent?.updateRow(parentRow)
            parent?.didChangedRow(parentRow)
            
            if parentRow.timeForAutoselection > 0.499 {
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoselection), object: nil)
                self.perform(#selector(autoselection), with: nil, afterDelay: parentRow.timeForAutoselection)
            }
        }
    }
    
    open func autoselection() {
        if let parentRow = data.parent
        {
            if parentRow.isOpened {
                parentRow.isOpened = false
                parent?.deleteRow(data)
                parent?.updateRow(parentRow)
            }
        }
    }
    
}
