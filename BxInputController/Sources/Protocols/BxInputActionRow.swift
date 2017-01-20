//
//  BxInputActionRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 16/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

public protocol BxInputActionRow: BxInputStringRow
{
    var handler: ((_ actionRow: BxInputActionRow) -> Void)? {get}
    
    var isImmediatelyDeselect: Bool {get}
}
