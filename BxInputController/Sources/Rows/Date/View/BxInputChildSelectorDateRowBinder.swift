/**
 *	@file BxInputChildSelectorDateRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputChildSelectorDateRow subclasses
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputChildSelectorDateRow subclasses
open class BxInputChildSelectorDateRowBinder<Row: BxInputChildSelectorDateRow, Cell: BxInputChildSelectorDateCell, ParentRow: BxInputSelectorDateRow> : BxInputChildSelectorRowBinder<Row, Cell, ParentRow>, BxInputChildSelectorDateDelegate
{
    /// update cell from model data, in inherited cell need call super!
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
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.datePicker.isEnabled = value
        cell?.datePicker.isUserInteractionEnabled = value
        cell?.datePicker.alpha = value ? 1.0 : 0.5
    }
    
    // MARK - BxInputChildSelectorDateDelegate
    
    /// editing date from Picker
    open func changeDate(datePicker: UIDatePicker) {
        parentRow.value = cell?.datePicker.date
        owner?.updateRow(parentRow)
        owner?.didChangedRow(parentRow)
        
        tryToClose()
    }
    
}
