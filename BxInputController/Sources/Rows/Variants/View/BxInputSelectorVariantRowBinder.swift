//
//  BxInputSelectorVariantRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 22/11/2018.
//  Copyright © 2018 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorVariantRowBinder<T: BxInputStringObject, Row: BxInputSelectorVariantRow<T>, Cell: BxInputSelectorCell>: BxInputSelectorRowBinder<Row, Cell>, BxInputValueItemsRowBinderProtocol
{
    open func didResetItems() {
        toClose()
    }

    public func searchValue(_ string: String) -> T? {
        row.items.first(where: { return $0.stringValue == string })
    }
}
