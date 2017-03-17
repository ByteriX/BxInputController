//
//  BxInputSelectorTextRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 17/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorTextRowBinder<Row: BxInputSelectorTextRow, Cell: BxInputSelectorCell>: BxInputSelectorRowBinder<Row, Cell>
{
    
    /// visual updating of value && separator that depends on type of the row
    override open func checkValue() {
        super.checkValue()
        // changing for BxInputSelectorTextRow
        var separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        if let settings = owner?.settings {
            separatorInset = settings.separatorInset
        }
        if row.isOpened {
            separatorInset.left = cell?.frame.size.width ?? 16
            // for hide in selector text when row is opened
            cell?.valueTextField.text = ""
        }
        cell?.separatorInset = separatorInset
    }
    
}
