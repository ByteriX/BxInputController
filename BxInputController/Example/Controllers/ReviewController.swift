//
//  ReviewController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 02/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class ReviewController: BxInputController
{
    
    private var rateValue = BxInputRateRow(title: "Rate", value: 3.5)
    private var disabledRateValue = BxInputRateRow(title: "Disabled rate", value: 2.5)
    private var customRateValue = BxInputRateRow(title: "Custom rate", maxValue: 7, activeColor: UIColor.blue)
    private var bigRateValue = BxInputRateRow(title: "Big rate", maxValue: 3, activeColor: UIColor.yellow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disabledRateValue.isEnabled = false
        customRateValue.passiveColor = UIColor(white: 0.9, alpha: 1)
        customRateValue.width = 100
        bigRateValue.passiveColor = bigRateValue.activeColor.withAlphaComponent(0.2)
        bigRateValue.width = 200
        
        self.sections = [
            BxInputSection(headerText: "Rate", rows: [rateValue, disabledRateValue, customRateValue, bigRateValue]),
        ]
    }
    
}
