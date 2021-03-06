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

/// Common cell for textual rows which have title & value
open class BxInputStandartTextCell: UITableViewCell, BxInputFieldCell {

    /// caption of the row
    @IBOutlet public weak var titleLabel: UILabel!
    /// caption of title for the row. This is only option field
    @IBOutlet public weak var subtitleLabel: UILabel?
    /// for managment of position subtitle
    @IBOutlet public weak var subtitleBottomMargin: NSLayoutConstraint?
    /// value for the row or a putting example
    @IBOutlet public weak var valueTextField: UITextField!
    
    /// value editing event
    @available(iOS, deprecated: 6.0, message: "This method can't call and will be removed in a future. Please remove reference from xib.")
    @IBAction func valueTextFieldEditingChanged(_ sender: Any) {
        // this need mark as depricated
    }

}

