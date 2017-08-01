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
    
    /// highlighed color for marking a value. If is nil then get value from BxInputSettings Default nil.
    public var color : UIColor? = nil
    /// if is defined, will change existing placeholder of value to this value
    public var placeholder : String? = nil
    /// if is defined, will change existing subtitle of row to this value.
    public var subtitle : String? = nil
    
    /// method calls when need show activation of something event
    open func activate(binder: BxInputRowBinder)
    {
        // common changes
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.update(binder: binder)
        }
        var view: UIView? = nil
        // foregen changes with views
        if let cell = binder.viewCell as? BxInputFieldCell,
            let text = cell.valueTextField.text,
            text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty == false ||
                text.isEmpty == true && cell.valueTextField.placeholder?.isEmpty == false
        {
            view = cell.valueTextField
        } else if let cell = binder.viewCell as? BxInputTitleCell,
            let text = cell.titleLabel.text,
            text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty == false
        {
            view = cell.titleLabel
        }  else if let cell = binder.viewCell as? BxInputTextMemoCell
        {
            view = cell.textView
        }
        
        if let view = view
        {
            let shift = view.frame.size.height * 2
            view.shakeX(withOffset: fabs(shift), breakFactor: 0.5, duration: 0.5 + fabs(shift / 100.0), maxShakes: Int(fabs(shift * 2.0)))
        }
    }
    
    /// method calls when binder update row
    open func update(binder: BxInputRowBinder) {
        var color = UIColor.red
        if let thisColor = self.color {
            color = thisColor
        } else if let globalColor = binder.owner?.settings.errorColor {
            color = globalColor
        }
        
        if let cell = binder.viewCell as? BxInputTitleCell {
            
            cell.titleLabel.textColor = color
            
            if let cell = binder.viewCell as? BxInputFieldCell {
                cell.valueTextField.textColor = color
                var placeholder = self.placeholder
                if placeholder == nil {
                    placeholder = binder.rowData.placeholder
                }
                if let placeholder = placeholder {
                    cell.valueTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : color.withAlphaComponent(0.3)])
                }
            }
            if let subtitleLabel = cell.subtitleLabel {
                subtitleLabel.textColor = color
                if let subtitle = subtitle {
                    subtitleLabel.textAlignment = .right
                    subtitleLabel.text = subtitle
                }
            }
        } else if let cell = binder.viewCell as? BxInputTextMemoCell
        {
            cell.textView.textColor = color
            var placeholder = self.placeholder
            if placeholder == nil {
                placeholder = binder.rowData.placeholder
            }
            if let placeholder = placeholder {
                cell.textView.placeholderColor = color.withAlphaComponent(0.3)
                cell.textView.placeholder = placeholder
            }
        }
    }
    
    /// method calls when need show activation of something event
    open func deactivate(binder: BxInputRowBinder)
    {
        binder.update()
    }
    
}
