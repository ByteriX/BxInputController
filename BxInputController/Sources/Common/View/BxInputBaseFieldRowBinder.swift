/**
 *	@file BxInputBaseFieldRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Base class for binding row data model with base field cell
 *	@date 25.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Base class for binding row data model with base field cell
open class BxInputBaseFieldRowBinder<Row: BxInputRow, Cell> : BxInputBaseTitleRowBinder<Row, Cell>
    where Cell : UITableViewCell, Cell : BxInputFieldCell
{
    
    /// update cell from model data
    override open func update()
    {
        super.update()
        cell?.valueTextField.font = owner?.settings.valueFont
        cell?.valueTextField.textColor = owner?.settings.valueColor
        cell?.valueTextField.setPlaceholder(row.placeholder, with: owner?.settings.placeholderColor)
    }
    
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        cell.valueTextField.isEnabled = value
        // UI part
        if needChangeDisabledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.valueTextField, isEnabled)
            } else {
                cell.valueTextField.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.valueTextField.alpha = 1
        }
    }
    
}
