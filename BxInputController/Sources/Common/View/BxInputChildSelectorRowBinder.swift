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
    var parentData: ParentRow
    
    override init(row: Row)
    {
        parentData = row.parent as! ParentRow
        super.init(row: row)
    }
    
    open func tryToClose() {
        if parentData.timeForAutoselection > 0.499 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoclose), object: nil)
            self.perform(#selector(autoclose), with: nil, afterDelay: parentData.timeForAutoselection)
        }
    }
    
    open func autoclose() {
        if parentData.isOpened {
            parentData.isOpened = false
            owner?.deleteRow(row)
            owner?.updateRow(parentData)
        }
    }
}
