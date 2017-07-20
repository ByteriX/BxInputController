/**
 *	@file BxInputRateRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputRateRow subclasses
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxObjC

/// Binder for BxInputRateRow subclasses
open class BxInputRateRowBinder<Row: BxInputRateRow, Cell: BxInputRateCell> : BxInputBaseTitleRowBinder<Row, Cell>, BxStandartRateViewDelegate
{
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        
        owner?.dissmissAllRows()
    }
    /// update cell from model data
    override open func update()
    {
        super.update()
        //
        guard let cell = cell else {
            return
        }
        // backward call delegate
        cell.valueRateView.delegate = self

        cell.selectionStyle = .none
        
        cell.valueRateView.maxRating = Int32(row.maxValue)
        cell.rateWidthConstraint.constant = row.width
        let starImage = BxInputUtils.getImage(resourceId: "bx_rate_star")
        if let passiveColor = row.passiveColor {
            cell.valueRateView.notSelectedImage = starImage.maskedImage(by: passiveColor)
        } else {
            cell.valueRateView.notSelectedImage = starImage
        }
        cell.valueRateView.selectedImage = starImage.maskedImage(by: row.activeColor)
        cell.valueRateView.halfSelectedImage = starImage.halfMaskedImage(by: row.activeColor)
        
        if let rate = row.value {
            cell.valueRateView.rating = rate
        } else {
            cell.valueRateView.rating = 0
        }
        
        updateChecking()
    }
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        cell.valueRateView.editable = value
        // UI part
        if needChangeDisadledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.valueRateView, isEnabled)
            } else {
                cell.valueRateView.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.valueRateView.alpha = 1
        }
    }
    
    // MARK - BxStandartRateViewDelegate
    
    /// change rating value
    open func standartRateView(_ rateView: BxStandartRateView!, ratingDidChange rating: Float)
    {
        row.value = rating
        didChangedValue(for: row)
    }
    
}
