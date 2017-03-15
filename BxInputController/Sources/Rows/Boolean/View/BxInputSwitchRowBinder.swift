//
//  BxInputSwitchRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputSwitchRowBinder<Row: BxInputSwitchRow, Cell: BxInputSwitchCell> : BxInputBaseRowBinder<Row, Cell>, BxInputSwitchDelegate
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
        cell?.delegate = self
        //
        cell?.titleLabel.font = owner?.settings.titleFont
        cell?.titleLabel.textColor = owner?.settings.titleColor
        cell?.titleLabel.text = row.title
        
        cell?.selectionStyle = .none
        
        cell?.valueSwitch.setOn(row.value, animated: false)
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.valueSwitch.isEnabled = value
        //cell?.valueSwitch.alpha = value ? 1 : 0.5
        cell?.titleLabel.alpha = value ? 1 : 0.5
    }
    
    /// event change value from switch button
    open func valueDidChanged(valueSwitch: UISwitch)
    {
        row.value = valueSwitch.isOn
        owner?.didChangedRow(row)
    }
}
