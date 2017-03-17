//
//  BxInputActionRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 17/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputActionCustomRowBinder<T : BxInputString, Cell : BxInputStandartTextCell>: BxInputStandartTextRowBinder<BxInputActionCustomRow<T>, Cell>
{
    
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
    
    override open func updateCell()
    {
        cell?.valueTextField.isEnabled = false
        cell?.valueTextField.text = row.stringValue // may be all values rewrite to stringValue
        cell?.accessoryType = .disclosureIndicator
        cell?.selectionStyle = .default
    }
}

