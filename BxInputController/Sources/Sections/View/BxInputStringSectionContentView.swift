/**
 *	@file BxInputStringSectionContentView.swift
 *	@namespace BxInputController
 *
 *	@details View for section with string data content
 *	@date 19.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// View for section with string data content
open class BxInputStringSectionContentView: UITableViewHeaderFooterView {
    
    /// text content label
    @IBOutlet weak open var contentLabel: UILabel!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
