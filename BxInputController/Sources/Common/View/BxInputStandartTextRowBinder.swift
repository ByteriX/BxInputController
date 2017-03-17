//
//  BxInputStandartTextRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputStandartTextRowBinder<Row: BxInputRow, Cell: BxInputStandartTextCell> : BxInputBaseRowBinder<Row, Cell>, BxInputStandartTextDelegate, UITextFieldDelegate
{
    
    override open func didSelected()
    {
        super.didSelected()
        
        cell?.valueTextField.becomeFirstResponder()        
    }
    
    open func updateCell() {
        cell?.valueTextField.isEnabled = true
        cell?.accessoryType = .none
        cell?.selectionStyle = .none
    }
    
    override open func update()
    {
        super.update()
        cell?.delegate = self
        //
        cell?.titleLabel.font = owner?.settings.titleFont
        cell?.titleLabel.textColor = owner?.settings.titleColor
        cell?.valueTextField.font = owner?.settings.valueFont
        cell?.valueTextField.textColor = owner?.settings.valueColor
        //
        cell?.titleLabel.text = row.title
        
        // reset cell for reuse subclass
        cell?.valueTextField.isSecureTextEntry = false
        
        if let placeholder = row.placeholder,
            let placeholderColor = owner?.settings.placeholderColor
        {
            cell?.valueTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : placeholderColor])
        } else {
            cell?.valueTextField.placeholder = row.placeholder
        }
        
        updateCell()
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.valueTextField.isEnabled = value
        cell?.valueTextField.alpha = value ? 1 : 0.5
        cell?.titleLabel.alpha = value ? 1 : 0.5
    }
    
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        return cell?.valueTextField.resignFirstResponder() ?? false
    }
    
    /// event when value is changed
    open func valueChanged(valueTextField: UITextField) {
        //
    }
    
    
    // MARK - UITextFieldDelegate delegates
    
    
    /// start editing
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if !isEnabled {
            return false
        }
        if let owner = owner, owner.settings.isAutodissmissSelector {
            owner.dissmissSelectors()
        }
        owner?.activeRow = row
        owner?.activeControl = textField
        return true
    }
    
    /// end editing
    open func textFieldDidEndEditing(_ textField: UITextField)
    {
        if owner?.activeControl === textField {
            owner?.activeControl = nil
        }
        if owner?.activeRow === row {
            owner?.activeRow = nil
        }
    }
    
    /// changing value event for correct showing
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if let text = textField.text,
            range.location == text.characters.count && string == " "
        {
            textField.text = text + "\u{00a0}"
            return false
        }
        return true
    }
    
    /// clear event, when user click clear button
    open func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        textField.text = ""
        return true
    }
    
    /// user click Done
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    

}
