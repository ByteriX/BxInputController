//
//  BxInputSelectorDateRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorDateRowBinder<Row: BxInputChildSelectorDateRow, Cell: BxInputSelectorDateCell, ParentRow: BxInputSelectorDateRow> : BxInputChildSelectorRowBinder<Row, Cell, ParentRow>, BxInputSelectorDateDelegate
{
    
    override open func update()
    {
        super.update()
        guard let cell = cell else {
            return
        }
        cell.delegate = self

            cell.datePicker.minimumDate = parentData.minimumDate
            cell.datePicker.maximumDate = parentData.maximumDate
            if let date = parentData.value {
                cell.datePicker.setDate(date, animated: false)
            } else {
                cell.datePicker.setDate(Date(), animated: false)
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
        parentData.value = cell?.datePicker.date
        parent?.updateRow(parentData)
        parent?.didChangedRow(parentData)
        
        tryToClose()
    }
    
}
