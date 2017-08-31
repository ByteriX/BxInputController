/**
 *	@file BxInputSelectorRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for a selector row
 *	@date 06.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for a selector row
open class BxInputSelectorRowBinder<Row: BxInputSelectorRow, Cell: BxInputSelectorCell>: BxInputBaseFieldRowBinder<Row, Cell>
{
    /// call when user selected this cell
    override open func didSelected()
    {
        super.didSelected()
        
        row.isOpened = !row.isOpened
        
        refreshOpened(animated: true)
        
        if row.isOpened {
            owner?.addRows(row.children, after: row)
            
            if let owner = owner, owner.settings.isAutodissmissSelector {
                owner.dissmissAllRows(exclude: row)
            }
            
            if row.children.count > 1 {
                owner?.scrollRow(row, at: .top, animated: true)
            } else if let firstItem = row.children.first {
                owner?.selectRow(firstItem, at: .middle, animated: true)
                //parent?.scrollRow(firstItem, at: .middle, animated: true)
            } else {
                owner?.scrollRow(row, at: .middle, animated: true)
            }
            owner?.activeRow = row
        } else {
            owner?.deleteRows(row.children)
        }
    }
    
    /// update cell from model data
    override open func update()
    {
        super.update()
        //
        cell?.arrowImage.image = BxInputUtils.getImage(resourceId: "bx_arrow_to_bottom")
        //
        refreshOpened(animated: false)
    }
    
    /// event of change isEnabled
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        guard let cell = cell else {
            return
        }
        // UI part
        if needChangeDisabledCell {
            if let changeViewEnableHandler = owner?.settings.changeViewEnableHandler {
                changeViewEnableHandler(cell.arrowImage, isEnabled)
            } else {
                cell.arrowImage.alpha = value ? 1 : alphaForDisabledView
            }
        } else {
            cell.arrowImage.isHidden = !value
        }
    }
    
    /// visual updating of state from opened/closed
    open func refreshOpened(animated: Bool) {
        if animated {
            UIView.beginAnimations(nil, context: nil)
        }
        if row.isOpened {
            cell?.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        } else {
            cell?.arrowImage.transform = CGAffineTransform.identity
        }
        checkValue()
        if animated {
            UIView.commitAnimations()
        }
    }
    
    /// visual updating of value && separator that depends on type of the row
    open func checkValue() {
        // all string changing of value
        if let row = row as? BxInputString{
            cell?.valueTextField.text = row.stringValue
        } else {
            cell?.valueTextField.text = ""
        }
    }

}
