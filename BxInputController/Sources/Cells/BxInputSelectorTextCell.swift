//
//  BxInputSelectorTextCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 02/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputSelectorTextCell: BxInputStandartCell {

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
        if let row = data as? BxInputChildSelectorTextRow,
            let parentRow = row.parent as? BxInputSelectorTextRow
        {
            textView.text = parentRow.value
            
//            DispatchQueue.main.async { [weak self] () -> Void in
//                if let variantsPicker = self?.variantsPicker {
//                    self?.pickerView(variantsPicker, didSelectRow: index, inComponent: 0)
//                }
//            }
        }
    }
    
    open func autoselection() {
        if let row = data as? BxInputChildSelectorTextRow,
            let parentRow = row.parent
        {
            if parentRow.isOpened {
                parentRow.isOpened = false
                parent?.deleteRow(row)
                parent?.updateRow(parentRow)
            }
        }
    }
    
    func check()
    {
        if checkContent() {
            checkScroll()
        }
    }
    
    func checkScroll()
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
    
    func checkContent() -> Bool
    {
        let shift = textView.contentSize.height - textView.frame.size.height
        if shift > 0 {
            if let row = data as? BxInputChildSelectorTextRow,
                let parentRow = row.parent
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

extension BxInputSelectorTextCell : UITextViewDelegate
{
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        self.perform(#selector(check), with: nil, afterDelay: 0.5)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView)
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
