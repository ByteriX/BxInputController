/**
 *	@file BxInputCheckRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for check box row subclasses
 *	@date 17.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for check box Row subclasses
open class BxInputCheckRowBinder<Row : BxInputCheckRow, Cell>: BxInputStandartTextRowBinder<Row, Cell>
where Cell : UITableViewCell, Cell : BxInputFieldCell
{
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        
        owner?.dissmissAllRows()
        row.value = !row.value
        update()
    }
    
    /// call after common update for text attributes updating
    override open func updateCell()
    {
        cell?.valueTextField.isEnabled = false
        cell?.valueTextField.text = ""
        cell?.accessoryType = row.value ? .checkmark : .none
        cell?.selectionStyle = .default
    }
}
