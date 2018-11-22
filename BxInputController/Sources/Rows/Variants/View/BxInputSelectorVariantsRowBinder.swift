//
//  BxInputSelectorVariantsRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 22/11/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorVariantsRowBinder<T: BxInputStringObject, Row: BxInputSelectorVariantsRow<T>, Cell: BxInputSelectorCell>: BxInputSelectorRowBinder<Row, Cell>, BxInputRowBinderMenuDelete
{
    open func deleteValue() {
        row.value = nil
        update()
        didChangeValue()
        toClose()
    }
}
