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

/// delegate for BxInputSwitchCell
public protocol BxInputSwitchDelegate: AnyObject
{
    /// change value of Switch
    func valueDidChanged(valueSwitch: UISwitch)
}

/// Cell with switch button for boolean row
open class BxInputSwitchCell: UITableViewCell {
    /// delegate
    public weak var delegate: BxInputSwitchDelegate? = nil

    /// caption of row
    @IBOutlet weak open var titleLabel: UILabel!
    /// switch button for changing value
    @IBOutlet weak open var valueSwitch: UISwitch!
    /// action from UISwitch
    @IBAction func valueDidChanged()
    {
        if let valueSwitch = valueSwitch {
            delegate?.valueDidChanged(valueSwitch: valueSwitch)
        }
    }
}
