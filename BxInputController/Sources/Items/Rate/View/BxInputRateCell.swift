//
//  BxInputRateCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 02/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit
import BxObjC

public class BxInputRateCell: BxInputBaseCell, BxStandartRateViewDelegate {
    
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var valueRateView: BxStandartRateView!
    @IBOutlet weak var rateWidthConstraint: NSLayoutConstraint!
    
    override open func didSelected()
    {
        super.didSelected()
        
        //
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

    
    open func standartRateView(_ rateView: BxStandartRateView!, ratingDidChange rating: Float)
    {
        if let rateRow = data as? BxInputRateRow
        {
            rateRow.value = rating
        }
    }
    
}
