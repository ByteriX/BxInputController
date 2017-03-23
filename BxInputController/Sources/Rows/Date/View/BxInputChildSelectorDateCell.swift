/**
 *	@file BxInputChildSelectorDateCell.swift
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

/// delegate for BxInputChildSelectorDateCell
public protocol BxInputChildSelectorDateDelegate: AnyObject {
    /// call when date did changed
    func editedDate()
    
}

/// Cell with date selector. Use as child for BxInputSelectorDateRow
open class BxInputChildSelectorDateCell: UITableViewCell {
    
    /// delegate
    public weak var delegate: BxInputChildSelectorDateDelegate? = nil

    /// choosing Date
    @IBOutlet weak open var datePicker: UIDatePicker!
    
    /// editing Date
    @IBAction open func changeDate(_ sender: Any) {
        delegate?.editedDate()
    }
    
}
