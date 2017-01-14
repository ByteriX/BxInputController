//
//  BxInputStandartHeaderFooter.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputStandartHeaderFooter : UITableViewHeaderFooterView
{
    
    weak var parent: BxInputController? = nil
    internal var data: BxInputSectionContent? = nil
    
    func update(data: BxInputSectionContent)
    {
        self.data = data
    }
    
}
