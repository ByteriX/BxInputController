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
open class BxInputSwitchCell: UITableViewCell {

    /// caption of row
    @IBOutlet weak open var titleLabel: UILabel!
    /// switch button for changing value
    @IBOutlet weak open var valueSwitch: UISwitch!
}
