/**
 *	@file BxInputSelectorTextCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for selector Row with longest text string
 *	@date 02.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Cell for selector Row with longest text string
public class BxInputSelectorTextCell: BxInputBaseCell {

    @IBOutlet var textView: UITextView!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override open func didSelected()
    {
        super.didSelected()
        
        textView.becomeFirstResponder()
    }
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        textView.font = parent?.settings.valueFont
        textView.textColor = parent?.settings.valueColor
        //
        if let row = data as? BxInputChildSelectorTextRow,
            let parentRow = row.parent as? BxInputSelectorTextRow
        {
            textView.text = parentRow.value
        }
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        if !value {
            textView.resignFirstResponder()
        }
        textView.isUserInteractionEnabled = value
        textView.alpha = value ? 1 : 0.5
    }
    
    open func check()
    {
        if checkContent() {
            checkScroll()
        }
    }
    
    open func checkScroll()
    {
        if let position = textView.selectedTextRange?.start,
            let parent = parent
        {
            let rect = textView.caretRect(for: position)
            let rectInTable = parent.tableView.convert(rect, from: textView)
            let shift =  8 + rectInTable.origin.y + rectInTable.size.height - ( parent.tableView.contentOffset.y + parent.tableView.frame.size.height - parent.tableView.contentInset.bottom)
            if shift > 0 {
                let point = CGPoint(x: parent.tableView.contentOffset.x, y: parent.tableView.contentOffset.y + shift + 4)
                parent.tableView.setContentOffset(point, animated: true)
            }
        }
    }
    
    open func checkContent() -> Bool
    {
        let shift = textView.contentSize.height - textView.frame.size.height
        if shift > 0 {
            if let row = data as? BxInputChildSelectorTextRow
            {
                row.height = row.height + shift + 1
                parent?.reloadRow(row, with: .none)
                parent?.selectRow(row, at: .none, animated: false)
                return false
            }
        }
        return true
    }
    
}

/// Implementation UITextViewDelegate for BxInputSelectorTextCell
extension BxInputSelectorTextCell : UITextViewDelegate
{
    
    open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        if let row = data as? BxInputChildSelectorTextRow,
            let parentRow = row.parent as? BxInputSelectorTextRow
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
        if let row = data as? BxInputChildSelectorTextRow,
            let parentRow = row.parent as? BxInputSelectorTextRow
        {
            parentRow.value = textView.text
            parent?.updateRow(parentRow)
            check()
        }
    }
    
}
