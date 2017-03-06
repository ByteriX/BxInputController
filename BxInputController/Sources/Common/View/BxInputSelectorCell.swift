/**
 *	@file BxInputSelectorCell.swift
 *	@namespace BxInputController
 *
 *	@details BxInputSelectorCell parent cell for rows with BxInputSelectorRow implemention
 *	@date 12.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// BxInputSelectorCell parent cell for rows with BxInputSelectorRow implemention
open class BxInputSelectorCell: BxInputBaseCell {
    
    /// caption of the row
    @IBOutlet weak var titleLabel: UILabel!
    /// value from selected field
    @IBOutlet weak var valueTextField: UITextField!
    /// arrow that show state of row closed/opened
    @IBOutlet weak var arrowImage: UIImageView!
    
}
