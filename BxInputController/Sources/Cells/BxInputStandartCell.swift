//
//  BxInputStandartCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputStandartCell: UITableViewCell {
    
    public weak var parent: BxInputController? = nil
    public var data: BxInputRow? = nil
    public var isEnabled: Bool = true
    {
        didSet {
            didSetEnabled(isEnabled)
        }
    }

    open func update(data: BxInputRow)
    {
        self.data = data
    }
    
    open func didSelected()
    {
        //
    }
    
    open func didSetEnabled(_ value: Bool)
    {
        //
    }
    
    override open func resignFirstResponder() -> Bool {
        return false
    }
    
}
