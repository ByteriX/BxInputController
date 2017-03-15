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
        cell?.textView.font = parent?.settings.valueFont
        cell?.textView.textColor = parent?.settings.valueColor
        //
        if let parentRow = data.parent as? BxInputSelectorTextRow
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
            let parent = parent
        {
            let rect = cell.textView.caretRect(for: position)
            let rectInTable = parent.tableView.convert(rect, from: cell.textView)
            let shift =  8 + rectInTable.origin.y + rectInTable.size.height - ( parent.tableView.contentOffset.y + parent.tableView.frame.size.height - parent.tableView.contentInset.bottom)
            if shift > 0 {
                let point = CGPoint(x: parent.tableView.contentOffset.x, y: parent.tableView.contentOffset.y + shift + 4)
                parent.tableView.setContentOffset(point, animated: true)
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
            data.height = data.height + shift + 1
            parent?.reloadRow(data, with: .none)
            parent?.selectRow(data, at: .none, animated: false)
            return false
        }
        return true
    }
    
    // MARK - UITextViewDelegate
    
    open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        if let parentRow = data.parent as? BxInputSelectorTextRow
        {
            parent?.activeRow = parentRow
        }
        parent?.activeControl = textView
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
        if let parentRow = data.parent as? BxInputSelectorTextRow
        {
            parentRow.value = textView.text
            parent?.updateRow(parentRow)
            check()
        }
    }
    
}

