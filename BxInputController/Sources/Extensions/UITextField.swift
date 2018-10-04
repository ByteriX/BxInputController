/**
 *	@file UITextField.swift
 *	@namespace BxInputController
 *
 *	@details UITextField extensions
 *	@date 24.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxTextField

/// UITextField extensions make working with them easaly
extension UITextField {
    
    /// placeholder with color or standart
    public func setPlaceholder(_ placeholderText: String?, with color: UIColor?)
    {
        if let placeholderText = placeholderText,
            let color = color
        {
            attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [BxTextField.attributedKeyForegroundColor : color])
        } else {
            attributedPlaceholder = nil
            placeholder = placeholderText
        }
    }
    
}
