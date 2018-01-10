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
open class BxInputStandartTextRowBinder<Row: BxInputRow, Cell> : BxInputBaseFieldRowBinder<Row, Cell>, UITextFieldDelegate
where Cell : UITableViewCell, Cell : BxInputFieldCell
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
    
    /// Update text input settings. If you want to specialize you can override this
    open func updateTextSettings() {
        cell?.valueTextField.update(from: BxInputTextSettings.standart)
    }
    
    /// update cell from model data
    override open func update()
    {
        super.update()
        //
        cell?.valueTextField.changeTarget(self, action: #selector(valueChanged(valueTextField:)), for: .editingChanged)
        cell?.valueTextField.delegate = self
        //
        updateTextSettings()
        updateCell()
    }
    
    /// resign value editing
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        return cell?.valueTextField.resignFirstResponder() ?? false
    }
    
    /// event when value is changed. Need reload this in inherited classes
    @objc open func valueChanged(valueTextField: UITextField) {
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
            range.location == text.chars.count && string == " "
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
