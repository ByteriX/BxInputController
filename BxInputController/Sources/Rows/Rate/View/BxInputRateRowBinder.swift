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
        
        parent?.dissmissAllRows()
    }
    
    override open func update()
    {
        super.update()
        //
        cell?.titleLabel.font = parent?.settings.titleFont
        cell?.titleLabel.textColor = parent?.settings.titleColor
        cell?.titleLabel.text = data.title
        cell?.valueRateView.delegate = self
        
        cell?.selectionStyle = .none
        
        let rateRow = data
        cell?.valueRateView.maxRating = Int32(rateRow.maxValue)
        cell?.rateWidthConstraint.constant = rateRow.width
        let starImage = BxInputUtils.getImage(resourceId: "bx_rate_star")
        if let passiveColor = rateRow.passiveColor {
            cell?.valueRateView.notSelectedImage = starImage.maskedImage(by: passiveColor)
        } else {
            cell?.valueRateView.notSelectedImage = starImage
        }
        cell?.valueRateView.selectedImage = starImage.maskedImage(by: rateRow.activeColor)
        cell?.valueRateView.halfSelectedImage = starImage.halfMaskedImage(by: rateRow.activeColor)
        
        if let rate = rateRow.value {
            cell?.valueRateView.rating = rate
        } else {
            cell?.valueRateView.rating = 0
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
        data.value = rating
        parent?.didChangedRow(data)
    }
    
}
