/**
 *	@file BxInputBaseTitleRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Base class for binding row data model with base title cell
 *	@date 25.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Base class for binding row data model with base title cell
open class BxInputBaseTitleRowBinder<Row: BxInputRow, Cell> : BxInputBaseRowBinder<Row, Cell>
    where Cell : UITableViewCell, Cell : BxInputTitleCell
{

    /// update cell from model data
    override open func update()
    {
        super.update()
        cell?.titleLabel.font = owner?.settings.titleFont
        cell?.titleLabel.textColor = owner?.settings.titleColor
        cell?.titleLabel.text = row.title
        if let subtitleLabel = cell?.subtitleLabel {
            subtitleLabel.font = owner?.settings.subtitleFont
            subtitleLabel.textColor = owner?.settings.subtitleColor
            if let margin = owner?.settings.subtitleMargin {
                cell?.subtitleBottomMargin?.constant = margin
            }
            if let alignment = owner?.settings.subtitleAlignment {
                subtitleLabel.textAlignment = alignment
            }
            subtitleLabel.text = row.subtitle
        }
    }
    
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        // UI part
        if needChangeDisadledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.titleLabel, isEnabled)
                if let subtitleLabel = cell.subtitleLabel {
                    changeViewEnableHandler(subtitleLabel, isEnabled)
                }
            } else {
                cell.titleLabel.alpha = value ? 1 : alphaForDisabledView
                if let subtitleLabel = cell.subtitleLabel {
                    subtitleLabel.alpha = value ? 1 : alphaForDisabledView
                }
            }
        } else {
            cell.titleLabel.alpha = 1
            if let subtitleLabel = cell.subtitleLabel {
                subtitleLabel.alpha = 1
            }
        }
    }

}
    
