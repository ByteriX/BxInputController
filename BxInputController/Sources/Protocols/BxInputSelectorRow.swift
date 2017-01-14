//
//  BxInputSelectorRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 12/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

protocol BxInputSelectorRow : BxInputRow
{
    
    var isOpened: Bool {get set}
    
    var children: [BxInputChildSelectorRow] {get}
    
}

protocol BxInputChildSelectorRow : BxInputRow
{
    
    weak var parent: BxInputSelectorRow? {get set}
    
}
