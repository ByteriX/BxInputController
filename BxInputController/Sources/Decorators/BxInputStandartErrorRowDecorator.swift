/**
 *	@file BxInputStandartErrorRowDecorator.swift
 *	@namespace BxInputController
 *
 *	@details Standart decoration for showing error message in row
 *	@date 24.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxObjC

/// Standart decoration for showing error message in row
open class BxInputStandartErrorRowDecorator : BxInputRowDecorator {
    
    public var markColor : UIColor = UIColor.red
    
    public var markPlaceholder : String? = nil
    
    public func mark(binder: BxInputRowBinder) {
        if let cell = binder.viewCell as? BxInputStandartTextCell {
            cell.titleLabel.textColor = markColor
            cell.valueTextField.textColor = markColor
            var placeholder = markPlaceholder
            if placeholder == nil {
                placeholder = binder.rowData.placeholder
            }
            if let placeholder = placeholder {
                cell.valueTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : markColor.withAlphaComponent(0.3)])
            }
        }
    }
    
    public func activation(binder: BxInputRowBinder) {
        if let cell = binder.viewCell as? BxInputStandartTextCell {
            let shift = cell.valueTextField.frame.size.height * 2
            cell.valueTextField.shakeX(withOffset: fabs(shift), breakFactor: 0.5, duration: 0.5 + fabs(shift / 100.0), maxShakes: Int(fabs(shift * 2.0)))
        }
        mark(binder: binder)
    }
    
    
}
