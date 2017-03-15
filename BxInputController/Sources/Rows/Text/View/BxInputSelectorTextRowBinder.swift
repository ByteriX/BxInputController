//
//  BxInputSelectorTextRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorTextRowBinder<Row: BxInputChildSelectorTextRow, Cell: BxInputSelectorTextCell> : BxInputBaseRowBinder<Row, Cell>, BxInputSelectorTextDelegate, UITextViewDelegate
{
    
    override open func didSelected()
    {
        super.didSelected()
        
        cell?.textView.becomeFirstResponder()
    }
    
    override open func update()
    {
        super.update()
        cell?.delegate = self
        //
        cell?.textView.font = owner?.settings.valueFont
        cell?.textView.textColor = owner?.settings.valueColor
        //
        if let parentRow = row.parent as? BxInputSelectorTextRow
        {
            cell?.textView.text = parentRow.value
        }
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        if !value {
            cell?.textView.resignFirstResponder()
        }
        cell?.textView.isUserInteractionEnabled = value
        cell?.textView.alpha = value ? 1 : 0.5
    }
    
    open func check()
    {
        if checkContent() {
            checkScroll()
        }
    }
    
    open func checkScroll()
    {
        guard let cell = cell else {
            return
        }
        if let position = cell.textView.selectedTextRange?.start,
            let owner = owner
        {
            let rect = cell.textView.caretRect(for: position)
            let rectInTable = owner.tableView.convert(rect, from: cell.textView)
            let shift =  8 + rectInTable.origin.y + rectInTable.size.height - ( owner.tableView.contentOffset.y + owner.tableView.frame.size.height - owner.tableView.contentInset.bottom)
            if shift > 0 {
                let point = CGPoint(x: owner.tableView.contentOffset.x, y: owner.tableView.contentOffset.y + shift + 4)
                owner.tableView.setContentOffset(point, animated: true)
            }
        }
    }
    
    open func checkContent() -> Bool
    {
        guard let cell = cell else {
            return false
        }
        let shift = cell.textView.contentSize.height - cell.textView.frame.size.height
        if shift > 0 {
            row.height = row.height + shift + 1
            owner?.reloadRow(row, with: .none)
            owner?.selectRow(row, at: .none, animated: false)
            return false
        }
        return true
    }
    
    // MARK - UITextViewDelegate
    
    open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        if let parentRow = row.parent as? BxInputSelectorTextRow
        {
            owner?.activeRow = parentRow
        }
        owner?.activeControl = textView
        return true
    }
    
    open func textViewDidBeginEditing(_ textView: UITextView)
    {
        self.perform(#selector(check), with: nil, afterDelay: 0.1)
    }
    
    open func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    {
        return true
    }
    
    open func textViewDidChange(_ textView: UITextView)
    {
        if let parentRow = row.parent as? BxInputSelectorTextRow
        {
            parentRow.value = textView.text
            owner?.updateRow(parentRow)
            check()
        }
    }
    
}

