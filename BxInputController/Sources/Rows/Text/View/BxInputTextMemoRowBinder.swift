/**
 *	@file BxInputTextMemoRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputTextMemoRow
 *	@date 01.08.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxObjC

/// Binder for BxInputTextMemoRow
open class BxInputTextMemoRowBinder<Row: BxInputTextMemoRow, Cell: BxInputTextMemoCell> : BxInputBaseRowBinder<Row, Cell>, BxInputTextMemoCellDelegate, UITextViewDelegate, BxInputTextMemoProtocol
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
        cell.textView.text = row.value
        cell.textView.placeholderColor = owner?.settings.placeholderColor
        cell.textView.placeholder = row.placeholder
        cell.textView.update(from: row.textSettings)

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
        if !isEnabled {
            return false
        }
        if let owner = owner, owner.settings.isAutodissmissSelector {
            owner.dissmissSelectors()
        }
        owner?.activeRow = row
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
        if owner?.activeControl === textView {
            owner?.activeControl = nil
        }
        if owner?.activeRow === row {
            owner?.activeRow = nil
        }
        return true
    }
    
    /// change value
    open func textViewDidChange(_ textView: UITextView)
    {
        row.value = textView.text
        didChangeValue()
        //owner?.updateRow(row) - it is redundant (2.7.9)
        check()
    }
    
    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if let maxCount = row.maxCount {
            if var textView = textView as? BxTextView {
                if textView.cutText(maxCount: maxCount, shouldChangeCharactersIn: range, replacementString: text) {
                    return false
                }
            }
        }
        return true
    }
    
}
