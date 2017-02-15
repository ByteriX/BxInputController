//
//  BxInputSwitchCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 15/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSwitchCell: BxInputBaseCell {

    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var valueSwitch: UISwitch!
    
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
        valueSwitch.addTarget(self, action: #selector(valueDidChanged), for: .valueChanged)
        
        self.selectionStyle = .none
        
        if let rateRow = data as? BxInputSwitchRow
        {
            valueSwitch.setOn(rateRow.value, animated: false)
        }
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        valueSwitch.isEnabled = value
        //valueSwitch.alpha = value ? 1 : 0.5
        titleLabel.alpha = value ? 1 : 0.5
    }
    
    open func valueDidChanged()
    {
        if let rateRow = data as? BxInputSwitchRow
        {
            rateRow.value = valueSwitch.isOn
            parent?.didChangedRow(rateRow)
        }
    }
    
}
