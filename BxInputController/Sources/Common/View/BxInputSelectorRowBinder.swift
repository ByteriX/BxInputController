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
        
        data.isOpened = !data.isOpened
        
        refreshOpened(animated: true)
        
        if data.isOpened {
            parent?.addRows(data.children, after: data)
            
            if let parent = parent, parent.settings.isAutodissmissSelector {
                parent.dissmissAllRows(exclude: data)
            }
            
            if data.children.count > 1 {
                parent?.scrollRow(data, at: .top, animated: true)
            } else if let firstItem = data.children.first {
                parent?.selectRow(firstItem, at: .middle, animated: true)
                //parent?.scrollRow(firstItem, at: .middle, animated: true)
            } else {
                parent?.scrollRow(data, at: .middle, animated: true)
            }
            parent?.activeRow = data
        } else {
            parent?.deleteRows(data.children)
        }
    }
    
    override open func update()
    {
        super.update()
        //
        cell?.arrowImage.image = BxInputUtils.getImage(resourceId: "bx_arrow_to_bottom")
        //
        cell?.titleLabel.font = parent?.settings.titleFont
        cell?.titleLabel.textColor = parent?.settings.titleColor
        cell?.valueTextField.font = parent?.settings.valueFont
        cell?.valueTextField.textColor = parent?.settings.valueColor
        //
        cell?.titleLabel.text = data.title
        
        if let placeholder = data.placeholder,
            let placeholderColor = parent?.settings.placeholderColor
        {
            cell?.valueTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : placeholderColor])
        } else {
            cell?.valueTextField.placeholder = data.placeholder
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
        guard let data = self.data as? BxInputSelectorRow else {
            return
        }
        if animated {
            UIView.beginAnimations(nil, context: nil)
        }
        if data.isOpened {
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
        if let settings = parent?.settings {
            separatorInset = settings.separatorInset
        }
        var isEmptyValue = false
        if let row = data as? BxInputSelectorTextRow {
            if row.isOpened {
                separatorInset.left = cell?.frame.size.width ?? 16
                cell?.separatorInset = separatorInset
                isEmptyValue = true
            }
        }
        cell?.separatorInset = separatorInset
        
        // all other changing of value
        if let dateRow = data as? BxInputSelectorDateRow {
            if let date = dateRow.value {
                cell?.valueTextField.text = parent?.settings.dateFormat.string(from: date)
            } else {
                cell?.valueTextField.text = ""
            }
        } else if let row = data as? BxInputStringRow,
            isEmptyValue == false
        {
            cell?.valueTextField.text = row.stringValue
        } else {
            cell?.valueTextField.text = ""
        }
        
    }

}
