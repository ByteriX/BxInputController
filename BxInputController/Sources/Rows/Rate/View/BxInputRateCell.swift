/**
 *	@file BxInputRateCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for select rating
 *	@date 02.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxObjC

/// Cell for select rating
open class BxInputRateCell: UITableViewCell, BxInputTitleCell {
    
    /// caption of row
    @IBOutlet weak open var titleLabel: UILabel!
    /// caption of title for the row. This is only option field
    @IBOutlet public weak var subtitleLabel: UILabel?
    /// for managment of position subtitle
    @IBOutlet public weak var subtitleBottomMargin: NSLayoutConstraint?
    /// rate control
    @IBOutlet weak open var valueRateView: BxStandartRateView!
    /// width constraint for rate control. It may unuse
    @IBOutlet weak var rateWidthConstraint: NSLayoutConstraint!

}
