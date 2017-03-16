//
//  BxInputSelectorSuggestionRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputSelectorSuggestionRowBinder<Row : BxInputChildSelectorRow, Cell: BxInputSelectorSuggestionCell> : BxInputChildSelectorRowBinder<Row, Cell, BxInputSelectorSuggestionsRow<Row>>
{
    
    override open func didSelected()
    {
        super.didSelected()

        parentRow.selectedChild = row
        parentRow.isOpened = false
        owner?.deleteRows(parentRow.children)
        owner?.updateRow(parentRow)
        owner?.didChangedRow(parentRow)
    }
    
    override open func update()
    {
        super.update()
        //
        cell?.titleLabel.font = owner?.settings.titleFont
        cell?.titleLabel.textColor = owner?.settings.titleColor
        //
        cell?.titleLabel.text = row.title
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.titleLabel.alpha = value ? 1.0 : 0.5
    }
    
}
