//
//  BxInputSelectorVariantRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 22/11/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorVariantRowBinder<T: BxInputStringObject, Row: BxInputSelectorVariantRow<T>, Cell: BxInputSelectorCell>: BxInputSelectorRowBinder<Row, Cell>, BxInputRowBinderMenuDelete
{
    
    open var canDeleteValue: Bool {
        return row.isEnabled && row.value != nil
    }
    
    open func deleteValue() {
        row.value = nil
        update()
        didChangeValue()
        toClose()
    }
}
