/**
 *	@file BxInputChildSelectorTextRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputChildSelectorTextRow subclasses
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxObjC

/// Binder for internal BxInputChildSelectorTextRow subclasses
open class BxInputChildSelectorTextRowBinder<Row: BxInputChildSelectorTextRow, Cell: BxInputChildSelectorTextCell, ParentRow: BxInputSelectorTextRow> : BxInputChildSelectorRowBinder<Row, Cell, ParentRow>, BxInputChildSelectorTextDelegate, UITextViewDelegate, BxInputTextMemoProtocol
{
    
    /// This field stored position of cursore of textView, how need update on cell
    internal var textPosition : UITextRange? = nil
    var memoCell: BxInputTextMemoCellProtocol?{ cell }
    var memoRow: BxInputTextMemoRowProtocol?{ row }
    
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        
        cell?.textView.becomeFirstResponder()
    }
    /// update cell from model data
    override open func update()
    {
        super.update()
        guard let cell = cell else {
            return
        }
        cell.delegate = self
        
        cell.textView.font = owner?.settings.valueFont
        cell.textView.textColor = owner?.settings.valueColor
        cell.textView.text = parentRow.value
        cell.textView.update(from: parentRow.textSettings)
        
        updateTextView()
        
    }
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        if !value {
            cell.textView.resignFirstResponder()
        }
        cell.textView.isUserInteractionEnabled = value
        // UI part
        if needChangeDisabledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.textView, isEnabled)
            } else {
                cell.textView.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.textView.alpha = 1
        }
    }
    
    /// check state of putting value
    @objc open func check()
    {
        if checkSize() {
            checkScroll()
        }
    }
    
    // MARK - UITextViewDelegate
    
    /// start editing
    open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool
    {
        owner?.activeRow = parentRow
        owner?.activeControl = textView
        return true
    }
    
    /// editing is started
    open func textViewDidBeginEditing(_ textView: UITextView)
    {
        self.perform(#selector(check), with: nil, afterDelay: 0.1)
    }
    
    /// end editing
    open func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    {
        return true
    }
    
    /// change value
    open func textViewDidChange(_ textView: UITextView)
    {
        parentRow.value = textView.text
        parentRowBinder.didChangeValue()
        //owner?.updateRow(parentRow)  - it is redundant (2.7.9) but fixed after 2.11
        check()
    }
    
    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if let maxCount = parentRow.maxCount {
            if var textView = textView as? BxTextView {
                if textView.cutText(maxCount: maxCount, shouldChangeCharactersIn: range, replacementString: text) {
                    return false
                }
            }
        }
        return true
    }
    
}

