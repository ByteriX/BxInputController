/**
 *    @file BxInputIconActionRowBinder.swift
 *    @namespace BxInputController
 *
 *    @details Binder for icon action row
 *    @date 26.06.2018
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2018 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for icon action row
open class BxInputIconActionRowBinder<T : BxInputString, Cell>: BxInputBaseTitleRowBinder<BxInputIconActionRow<T>, Cell>, BxInputRowBinderMenuDelete
    where Cell : BxInputIconActionCell
{
    
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        
        if let owner = owner, owner.settings.isAutodissmissSelector {
            owner.dissmissAllRows()
        }
        owner?.activeRow = row
        if let handler = row.handler {
            handler(row)
        }
    }
    
    override open func update()
    {
        super.update()
        guard let cell = cell else {
            return
        }
        if let titleColor = row.titleColor {
            cell.titleLabel.textColor = titleColor
        }
        if let icon = row.icon {
            cell.iconView.image = icon
            cell.iconView.isHidden = false
            var size = icon.size
            if let iconSize = row.iconSize {
                size = iconSize
            }
            cell.iconWidthMargin.constant = size.width
            cell.iconHeightMargin.constant = size.height
            cell.titleLeftMargin.constant = 16 + 8 + size.width
        } else {
            cell.iconView.image = nil
            cell.iconView.isHidden = true
            cell.titleLeftMargin.constant = 16
        }
        cell.valueLabel.text = row.stringValue
        cell.valueLabel.font = owner?.settings.valueFont
        cell.valueLabel.textColor = owner?.settings.valueColor
        //cell.valueLabel.setPlaceholder(row.placeholder, with: owner?.settings.placeholderColor)
    }
    
    open func deleteValue() {
        row.value = nil
        update()
        didChangeValue()
    }
}
