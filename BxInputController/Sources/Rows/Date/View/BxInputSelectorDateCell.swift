/**
 *	@file BxInputSelectorDateCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell with date selector. Use as child for BxInputSelectorDateRow
 *	@date 12.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

public protocol BxInputSelectorDateDelegate: AnyObject {
    
    func changeDate(datePicker: UIDatePicker)
    
}

/// Cell with date selector. Use as child for BxInputSelectorDateRow
open class BxInputSelectorDateCell: UITableViewCell {
    
    public weak var delegate: BxInputSelectorDateDelegate? = nil

    @IBOutlet weak open var datePicker: UIDatePicker!
    
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction open func changeDate(_ sender: Any) {
        if let datePicker = datePicker {
            delegate?.changeDate(datePicker: datePicker)
        }
    }
    
}
