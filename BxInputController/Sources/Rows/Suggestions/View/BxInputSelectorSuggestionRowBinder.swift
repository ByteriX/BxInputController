//
//  BxInputSelectorSuggestionRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


open class BxInputSelectorSuggestionRowBinder<Row: BxInputSelectorSuggestionsItemRow, Cell: BxInputSelectorSuggestionCell> : BxInputBaseRowBinder<Row, Cell>
{
    
    override open func didSelected()
    {
        super.didSelected()
        if let parentRow = data.parent as? BxInputParentSelectorSuggestionsRow
        {
            parentRow.selectedChild = data
            parentRow.isOpened = false
            parent?.deleteRows(parentRow.children)
            parent?.updateRow(parentRow)
            parent?.didChangedRow(parentRow)
        }
    }
    
    override open func update()
    {
        super.update()
        //
        cell?.titleLabel.font = parent?.settings.titleFont
        cell?.titleLabel.textColor = parent?.settings.titleColor
        //
        cell?.titleLabel.text = data.title
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        cell?.titleLabel.alpha = value ? 1.0 : 0.5
    }
    
}
