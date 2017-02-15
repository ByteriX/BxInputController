/**
 *	@file BxInputSelectorCell.swift
 *	@namespace BxInputController
 *
 *	@details BxInputSelectorCell parent cell for rows with BxInputSelectorRow implemention
 *	@date 12.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// BxInputSelectorCell parent cell for rows with BxInputSelectorRow implemention
open class BxInputSelectorCell: BxInputBaseCell {
    
    /// caption of the row
    @IBOutlet weak var titleLabel: UILabel!
    /// value from selected field
    @IBOutlet weak var valueTextField: UITextField!
    /// arrow that show state of row closed/opened
    @IBOutlet weak var arrowImage: UIImageView!
    
    override open func didSelected()
    {
        super.didSelected()
        arrowImage.image = BxInputUtils.getImage(resourceId: "bx_arrow_to_bottom")
        
        guard let data = self.data as? BxInputSelectorRow else {
            return
        }
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
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        titleLabel.font = parent?.settings.titleFont
        titleLabel.textColor = parent?.settings.titleColor
        valueTextField.font = parent?.settings.valueFont
        valueTextField.textColor = parent?.settings.valueColor
        //
        titleLabel.text = data.title
        
        if let placeholder = data.placeholder,
            let placeholderColor = parent?.settings.placeholderColor
        {
            valueTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName : placeholderColor])
        } else {
            valueTextField.placeholder = data.placeholder
        }

        refreshOpened(animated: false)
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        //valueTextField.isEnabled = value this is disabled everytime
        valueTextField.alpha = value ? 1 : 0.5
        titleLabel.alpha = value ? 1 : 0.5
        arrowImage.alpha = value ? 1 : 0.5
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
            arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        } else {
            arrowImage.transform = CGAffineTransform.identity
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
                separatorInset.left = self.frame.size.width
                self.separatorInset = separatorInset
                isEmptyValue = true
            }
        }
        self.separatorInset = separatorInset
        
        // all other changing of value
        if let dateRow = data as? BxInputSelectorDateRow {
            if let date = dateRow.value {
                valueTextField.text = parent?.settings.dateFormat.string(from: date)
            } else {
                valueTextField.text = ""
            }
        } else if let row = data as? BxInputStringRow,
            isEmptyValue == false
        {
            valueTextField.text = row.stringValue
        } else {
            valueTextField.text = ""
        }
        
    }
    
}
