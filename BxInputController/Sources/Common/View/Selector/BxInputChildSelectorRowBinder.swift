/**
 *	@file BxInputChildSelectorRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for children rows of selector type row
 *	@date 15.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for children rows of selector type row
open class BxInputChildSelectorRowBinder<Row: BxInputChildSelectorRow, Cell: UITableViewCell, ParentRow: BxInputSelectorRow> : BxInputBaseRowBinder<Row, Cell>
{
    
    /// parent row for easy access
    public var parentRow: ParentRow {
        return row.parent as! ParentRow
    }
    
    /// call if need check after end of putting data
    open func tryToClose() {
        if parentRow.timeForAutoselection > 0.499 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoclose), object: nil)
            self.perform(#selector(autoclose), with: nil, afterDelay: parentRow.timeForAutoselection)
        }
    }
    
    /// This should call automaticle for close this from parent
    @objc open func autoclose() {
        if parentRow.isOpened {
            parentRow.isOpened = false
            owner?.deleteRow(row)
            owner?.updateRow(parentRow)
        }
    }
}
