//
//  BxInputSwitchRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputSwitchRowBinder<Row: BxInputSwitchRow, Cell: BxInputSwitchCell> : BxInputBaseRowBinder<Row, Cell>
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
        cell?.valueSwitch.addTarget(self, action: #selector(valueDidChanged), for: .valueChanged)
        
        cell?.selectionStyle = .none
        
        cell?.valueSwitch.setOn(data.value, animated: false)
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.valueSwitch.isEnabled = value
        //cell?.valueSwitch.alpha = value ? 1 : 0.5
        cell?.titleLabel.alpha = value ? 1 : 0.5
    }
    
    /// event change value from switch button
    open func valueDidChanged()
    {
        if let isOn = cell?.valueSwitch.isOn {
            data.value = isOn
        }
        parent?.didChangedRow(data)
    }
}
