/**
 *    @file BxInputIconActionCell.swift
 *    @namespace BxInputController
 *
 *    @details Cell for action with icon rows
 *    @date 26.06.2018
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2018 ByteriX. See http://byterix.com
 */

import UIKit

/// Cell for action with icon rows
open class BxInputIconActionCell: UITableViewCell, BxInputTitleCell {
    
    /// icon of the row
    @IBOutlet public weak var iconView: UIImageView!
    /// caption of the row
    @IBOutlet public weak var titleLabel: UILabel!
    /// for managment of position title without icon
    @IBOutlet public weak var titleLeftMargin: NSLayoutConstraint!
    @IBOutlet public weak var iconWidthMargin: NSLayoutConstraint!
    @IBOutlet public weak var iconHeightMargin: NSLayoutConstraint!
    /// caption of title for the row. This is only option field
    @IBOutlet public weak var subtitleLabel: UILabel?
    /// for managment of position subtitle
    @IBOutlet public weak var subtitleBottomMargin: NSLayoutConstraint?
    /// value of the row
    @IBOutlet public weak var valueLabel: UILabel!
    
}
