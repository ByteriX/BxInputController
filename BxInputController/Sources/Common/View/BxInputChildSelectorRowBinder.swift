//
//  BxInputChildSelectorRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 15/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputChildSelectorRowBinder<Row: BxInputChildSelectorRow, Cell: UITableViewCell, ParentRow: BxInputSelectorRow> : BxInputBaseRowBinder<Row, Cell>
{
    var parentRow: ParentRow
    
    override init(row: Row)
    {
        parentRow = row.parent as! ParentRow
        super.init(row: row)
    }
    
    open func tryToClose() {
        if parentRow.timeForAutoselection > 0.499 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoclose), object: nil)
            self.perform(#selector(autoclose), with: nil, afterDelay: parentRow.timeForAutoselection)
        }
    }
    
    open func autoclose() {
        if parentRow.isOpened {
            parentRow.isOpened = false
            owner?.deleteRow(row)
            owner?.updateRow(parentRow)
        }
    }
}
