/**
 *	@file BxInputSwitchRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for switch row subclasses
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for switch row subclasses
open class BxInputSwitchRowBinder<Row: BxInputSwitchRow, Cell: BxInputSwitchCell> : BxInputBaseTitleRowBinder<Row, Cell>, BxInputSwitchDelegate
{
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        // This is realy called when was click
        owner?.dissmissAllRows()
    }
    /// update cell from model data, in inherited cell need call super!
    override open func update()
    {
        super.update()
        //
        cell?.delegate = self
        cell?.selectionStyle = .none
        cell?.valueSwitch.setOn(row.value, animated: false)
    }
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        cell.valueSwitch.isEnabled = value
        // UI part
        if needChangeDisabledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.valueSwitch, isEnabled)
            } else {
                //cell.valueSwitch.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.valueSwitch.alpha = 1
        }
    }
    
    // MARK - BxInputSwitchDelegate
    
    /// event change value from switch button
    open func valueDidChanged(valueSwitch: UISwitch)
    {
        row.value = valueSwitch.isOn
        didChangedValue(for: row)
    }
}
