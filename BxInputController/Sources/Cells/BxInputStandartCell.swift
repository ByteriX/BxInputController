//
//  BxInputStandartCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputStandartCell: UITableViewCell {
    
    weak var parent: BxInputController? = nil
    internal var data: BxInputRow? = nil

    func update(data: BxInputRow)
    {
        self.data = data
    }
    
    func didSelected()
    {
        //
    }
    
    override func resignFirstResponder() -> Bool {
        return false
    }
    
}
