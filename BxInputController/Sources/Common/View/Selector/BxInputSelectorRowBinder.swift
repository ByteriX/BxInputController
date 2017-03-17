//
//  BxInputSelectorRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorRowBinder<Row: BxInputSelectorRow, Cell: BxInputSelectorCell>: BxInputBaseRowBinder<Row, Cell>
{
    
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
    
    override open func update()
    {
        super.update()
        //
        cell?.arrowImage.image = BxInputUtils.getImage(resourceId: "bx_arrow_to_bottom")
        //
        cell?.titleLabel.font = owner?.settings.titleFont
        cell?.titleLabel.textColor = owner?.settings.titleColor
        cell?.valueTextField.font = owner?.settings.valueFont
        cell?.valueTextField.textColor = owner?.settings.valueColor
        //
        cell?.titleLabel.text = row.title
        
        if let placeholder = row.placeholder,
            let placeholderColor = owner?.settings.placeholderColor
        {
            cell?.valueTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : placeholderColor])
        } else {
            cell?.valueTextField.placeholder = row.placeholder
        }
        
        refreshOpened(animated: false)
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        //cell?.valueTextField.isEnabled = value this is disabled everytime
        cell?.valueTextField.alpha = value ? 1 : 0.5
        cell?.titleLabel.alpha = value ? 1 : 0.5
        cell?.arrowImage.alpha = value ? 1 : 0.5
    }
    
    /// visual updating of state from opened/closed
    open func refreshOpened(animated: Bool) {
        if animated {
            UIView.beginAnimations(nil, context: nil)
        }
        if row.isOpened {
            cell?.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
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
        // changing for BxInputSelectorTextRow
        var separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        if let settings = owner?.settings {
            separatorInset = settings.separatorInset
        }
        var isEmptyValue = false
        if let row = row as? BxInputSelectorTextRow {
            if row.isOpened {
                separatorInset.left = cell?.frame.size.width ?? 16
                cell?.separatorInset = separatorInset
                isEmptyValue = true
            }
        }
        cell?.separatorInset = separatorInset
        
        // all other changing of value
        if let dateRow = row as? BxInputSelectorDateRow {
            if let date = dateRow.value {
                cell?.valueTextField.text = owner?.settings.dateFormat.string(from: date)
            } else {
                cell?.valueTextField.text = ""
            }
        } else if let row = row as? BxInputStringRow,
            isEmptyValue == false
        {
            cell?.valueTextField.text = row.stringValue
        } else {
            cell?.valueTextField.text = ""
        }
        
    }

}
