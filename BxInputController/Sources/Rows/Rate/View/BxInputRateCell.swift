/**
 *	@file BxInputRateCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for select rating
 *	@date 02.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxObjC

/// Cell for select rating
public class BxInputRateCell: BxInputBaseCell {
    
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var valueRateView: BxStandartRateView!
    @IBOutlet weak var rateWidthConstraint: NSLayoutConstraint!
    
    override open func didSelected()
    {
        super.didSelected()
        
        parent?.dissmissAllRows()
    }
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        titleLabel.font = parent?.settings.titleFont
        titleLabel.textColor = parent?.settings.titleColor
        titleLabel.text = data.title
        valueRateView.delegate = self

        self.selectionStyle = .none

        if let rateRow = data as? BxInputRateRow
        {
            valueRateView.maxRating = Int32(rateRow.maxValue)
            rateWidthConstraint.constant = rateRow.width
            let starImage = BxInputUtils.getImage(resourceId: "bx_rate_star")
            if let passiveColor = rateRow.passiveColor {
                valueRateView.notSelectedImage = starImage.maskedImage(by: passiveColor)
            } else {
                valueRateView.notSelectedImage = starImage
            }
            valueRateView.selectedImage = starImage.maskedImage(by: rateRow.activeColor)
            valueRateView.halfSelectedImage = starImage.halfMaskedImage(by: rateRow.activeColor)
            
            if let rate = rateRow.value {
                valueRateView.rating = rate
            } else {
                valueRateView.rating = 0
            }
        } else {
            valueRateView.rating = 0
        }
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        valueRateView.editable = value
        valueRateView.alpha = value ? 1 : 0.5
        titleLabel.alpha = value ? 1 : 0.5
    }
    
}

/// Implementation BxStandartRateViewDelegate for BxInputRateCell
extension BxInputRateCell : BxStandartRateViewDelegate {
    
    /// change rating value
    open func standartRateView(_ rateView: BxStandartRateView!, ratingDidChange rating: Float)
    {
        if let rateRow = data as? BxInputRateRow
        {
            rateRow.value = rating
            parent?.didChangedRow(rateRow)
        }
    }
    
}
