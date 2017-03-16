//
//  BxInputRateRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit
import BxObjC

public class BxInputRateRowBinder<Row: BxInputRateRow, Cell: BxInputRateCell> : BxInputBaseRowBinder<Row, Cell>, BxStandartRateViewDelegate
{
    
    override open func didSelected()
    {
        super.didSelected()
        
        owner?.dissmissAllRows()
    }
    
    override open func update()
    {
        super.update()
        //
        guard let cell = cell else {
            return
        }
        //
        cell.valueRateView.delegate = self
        //
        cell.titleLabel.font = owner?.settings.titleFont
        cell.titleLabel.textColor = owner?.settings.titleColor
        cell.titleLabel.text = row.title
        
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
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.valueRateView.editable = value
        cell?.valueRateView.alpha = value ? 1 : 0.5
        cell?.titleLabel.alpha = value ? 1 : 0.5
    }
    
    // MARK - BxStandartRateViewDelegate
    
    /// change rating value
    open func standartRateView(_ rateView: BxStandartRateView!, ratingDidChange rating: Float)
    {
        row.value = rating
        owner?.didChangedRow(row)
    }
    
}
