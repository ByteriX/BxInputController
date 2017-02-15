/**
 *	@file BxInputSwitchCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell with switch button for boolean row
 *	@date 15.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Cell with switch button for boolean row
open class BxInputSwitchCell: BxInputBaseCell {

    /// caption of row
    @IBOutlet weak open var titleLabel: UILabel!
    /// switch button for changing value
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
    
    /// event change value from switch button
    open func valueDidChanged()
    {
        if let rateRow = data as? BxInputSwitchRow
        {
            rateRow.value = valueSwitch.isOn
            parent?.didChangedRow(rateRow)
        }
    }
    
}
