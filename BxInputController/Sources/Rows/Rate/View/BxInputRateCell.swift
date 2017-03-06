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
public class BxInputRateCell: BxInputBaseCell {
    
    @IBOutlet weak open var titleLabel: UILabel!
    @IBOutlet weak open var valueRateView: BxStandartRateView!
    @IBOutlet weak var rateWidthConstraint: NSLayoutConstraint!
    
    
    
}
