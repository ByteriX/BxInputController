/**
 *	@file BxInputChildSelectorSuggestionRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for suggestion selector Row subclasses
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for child suggestion selector Row subclasses
open class BxInputChildSelectorSuggestionRowBinder<Row : BxInputChildSelectorRow, Cell: BxInputChildSelectorSuggestionCell> : BxInputChildSelectorRowBinder<Row, Cell, BxInputSelectorSuggestionsRow<Row>>
{
    
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()

        parentRow.selectedChild = row
        parentRow.isOpened = false
        owner?.deleteRows(parentRow.children)
        owner?.updateRow(parentRow)
        parentRowBinder.didChangeValue()
    }
    
    /// update cell from model data
    override open func update()
    {
        super.update()
        //
        cell?.titleLabel.font = owner?.settings.titleFont
        cell?.titleLabel.textColor = owner?.settings.titleColor
        //
        cell?.titleLabel.text = row.title
    }
    
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        // UI part
        if needChangeDisabledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.titleLabel, isEnabled)
            } else {
                cell.titleLabel.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.titleLabel.alpha = 1
        }
    }
    
}
