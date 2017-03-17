/**
 *	@file BxInputStandartTextCell.swift
 *	@namespace BxInputController
 *
 *	@details Common cell for textual rows which have title & value
 *	@date 09.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

public protocol BxInputStandartTextDelegate : UITextFieldDelegate
{
    func valueChanged(valueTextField: UITextField)
}

/// Common cell for textual rows which have title & value
open class BxInputStandartTextCell: UITableViewCell {
    
    /// delegate
    public weak var delegate: BxInputStandartTextDelegate? = nil
    {
        didSet {
            valueTextField.delegate = delegate
        }
    }
    
    /// caption of the row
    @IBOutlet weak open var titleLabel: UILabel!
    /// value for the row or a putting example
    @IBOutlet weak open var valueTextField: UITextField!
    
    @IBAction func valueTextFieldEditingChanged(_ sender: Any) {
        delegate?.valueChanged(valueTextField: valueTextField)
    }

}
