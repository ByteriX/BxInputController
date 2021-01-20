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
        if #available(iOS 13.4, *) {
            cell.datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }

        DispatchQueue.main.async { [weak self] () -> Void in
            self?.updateDate(animated: false)
        }
    }
    
    open func updateDate(animated: Bool) {
        guard let cell = cell else {
            return
        }
        if let date = parentRow.value {
            cell.datePicker.setDate(date, animated: animated)
            changeDate()
        } else {
            cell.datePicker.setDate(parentRow.firstSelectionDate, animated: animated)
            editedDate()
        }
    }
    
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        cell.datePicker.isEnabled = value
        cell.datePicker.isUserInteractionEnabled = value
        
        // UI part
        if needChangeDisabledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.datePicker, isEnabled)
            } else {
                cell.datePicker.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.datePicker.alpha = 1
        }
    }
    
    func changeDate() {
        parentRow.value = cell?.datePicker.date
        owner?.updateRow(parentRow)
    }
    
    // MARK - BxInputChildSelectorDateDelegate
    
    /// editing date from Picker
    open func editedDate() {
        changeDate()
        parentRowBinder.didChangeValue()
        tryToClose()
    }
    
}
