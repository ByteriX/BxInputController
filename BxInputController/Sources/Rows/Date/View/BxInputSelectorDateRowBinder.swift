//
//  BxInputSelectorDateRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 17/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorDateRowBinder<Row: BxInputSelectorDateRow, Cell: BxInputSelectorCell>: BxInputSelectorRowBinder<Row, Cell>
{
    
    /// visual updating of value && separator that depends on type of the row
    override open func checkValue() {
        super.checkValue()
        if let date = row.value {
            cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
        } else {
            cell?.valueTextField.text = ""
        }
    }
    
}
