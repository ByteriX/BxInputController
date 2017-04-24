/**
 *	@file BxInputStandartTextRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for a standart text row
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for a standart text row
open class BxInputStandartTextRowBinder<Row: BxInputRow, Cell: BxInputStandartTextCell> : BxInputBaseRowBinder<Row, Cell>, BxInputStandartTextDelegate, UITextFieldDelegate
{
    
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        
        cell?.valueTextField.becomeFirstResponder()        
    }
    
    /// this call after common update for text attributes updating
    open func updateCell() {
        cell?.valueTextField.isEnabled = true
        cell?.accessoryType = .none
        cell?.selectionStyle = .none
    }
    
    /// update cell from model data
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
        
        cell?.valueTextField.setPlaceholder(row.placeholder, with: owner?.settings.placeholderColor)
        
        for checker in checkers {
            let isOK = checker.isOK(row: row)
            if let decorator = checker.decorator, isOK == false, checker.isActivated {
                decorator.mark(binder: self)
                break
            }
        }
        
        updateCell()
    }
    
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.valueTextField.isEnabled = value
        cell?.valueTextField.alpha = value ? 1 : 0.5
        cell?.titleLabel.alpha = value ? 1 : 0.5
    }
    
    /// resign value editing
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        return cell?.valueTextField.resignFirstResponder() ?? false
    }
    
    /// event when value is changed. Need reload this in inherited classes
    open func valueChanged(valueTextField: UITextField) {
        // empty
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
