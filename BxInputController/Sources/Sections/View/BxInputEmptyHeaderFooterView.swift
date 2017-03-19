/**
 *	@file BxInputEmptyHeaderFooterView.swift
 *	@namespace BxInputController
 *
 *	@details View for showing nothing if header or footer should be empty
 *	@date 16.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// View for showing nothing if header or footer should be empty
class BxInputEmptyHeaderFooterView: UITableViewHeaderFooterView {

    /// height for change if need
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
}
