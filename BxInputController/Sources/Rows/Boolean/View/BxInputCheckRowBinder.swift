//
//  BxInputCheckRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 17/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputCheckRowBinder<Row : BxInputCheckRow, Cell : BxInputStandartTextCell>: BxInputStandartTextRowBinder<Row, Cell>
{
    
    override open func didSelected()
    {
        super.didSelected()
        
        owner?.dissmissAllRows()
        row.value = !row.value
        update()
    }
    
    override open func updateCell()
    {
        cell?.valueTextField.isEnabled = false
        cell?.valueTextField.text = ""
        cell?.accessoryType = row.value ? .checkmark : .none
        cell?.selectionStyle = .default
    }
}
