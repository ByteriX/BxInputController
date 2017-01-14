//
//  BxInputStandartHeaderFooter.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputStandartHeaderFooter : UITableViewHeaderFooterView
{
    
    weak open var parent: BxInputController? = nil
    internal(set) public var data: BxInputSectionContent? = nil
    
    public func update(data: BxInputSectionContent)
    {
        self.data = data
    }
    
}
