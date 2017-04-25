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
open class BxInputSelectorCell: UITableViewCell, BxInputFieldCell {
    
    /// caption of the row
    @IBOutlet public weak var titleLabel: UILabel!
    /// caption of title for the row
    @IBOutlet public weak var subtitleLabel: UILabel?
    @IBOutlet weak var subtitleBottomMargin: NSLayoutConstraint?
    /// value from selected field
    @IBOutlet public weak var valueTextField: UITextField!
    /// arrow that show state of row closed/opened
    @IBOutlet public weak var arrowImage: UIImageView!
    
}
