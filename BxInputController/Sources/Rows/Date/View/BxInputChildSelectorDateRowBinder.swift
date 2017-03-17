//
//  BxInputChildSelectorDateRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputChildSelectorDateRowBinder<Row: BxInputChildSelectorDateRow, Cell: BxInputChildSelectorDateCell, ParentRow: BxInputSelectorDateRow> : BxInputChildSelectorRowBinder<Row, Cell, ParentRow>, BxInputChildSelectorDateDelegate
{
    
    override open func update()
    {
        super.update()
        guard let cell = cell else {
            return
        }
        cell.delegate = self

        cell.datePicker.minimumDate = parentRow.minimumDate
        cell.datePicker.maximumDate = parentRow.maximumDate
        if let date = parentRow.value {
            cell.datePicker.setDate(date, animated: false)
        } else {
            cell.datePicker.setDate(Date(), animated: false)
        }

        DispatchQueue.main.async { [weak self] () -> Void in
            if let datePicker = self?.cell?.datePicker {
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
        parentRow.value = cell?.datePicker.date
        owner?.updateRow(parentRow)
        owner?.didChangedRow(parentRow)
        
        tryToClose()
    }
    
}
