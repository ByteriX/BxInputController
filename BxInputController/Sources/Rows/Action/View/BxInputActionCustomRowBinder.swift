/**
 *	@file BxInputActionCustomRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for custom action row
 *	@date 17.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for custom action row
open class BxInputActionCustomRowBinder<T : BxInputString, Cell>: BxInputStandartTextRowBinder<BxInputActionCustomRow<T>, Cell>
where Cell : UITableViewCell, Cell : BxInputStandartTextCellProtocol
{
    
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        
        if let owner = owner, owner.settings.isAutodissmissSelector {
            owner.dissmissAllRows()
        }
        if let handler = row.handler {
            handler(row)
        }
    }
    
    /// call after common update for text attributes updating
    override open func updateCell()
    {
        cell?.valueTextField.isEnabled = false
        cell?.valueTextField.text = row.stringValue // may be all values rewrite to stringValue
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .default
    }
}

