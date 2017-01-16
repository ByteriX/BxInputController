//
//  BxInputSelectorCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 12/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorCell: BxInputStandartCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var arrowImage: UIImageView!

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func didSelected()
    {
        super.didSelected()
        guard let data = self.data as? BxInputSelectorRow else {
            return
        }
        data.isOpened = !data.isOpened
        refreshOpened(animated: true)
        
        if data.isOpened {
            parent?.addRows(data.children, after: data)
            
            if parent?.settings.isAutodissmissSelector ?? false {
                parent?.dissmissAllRows(exclude: data)
            }
            
            if data.children.count > 1 {
                parent?.scrollRow(data, at: .top, animated: true)
            } else if let firstItem = data.children.first {
                parent?.scrollRow(firstItem, at: .middle, animated: true)
            } else {
                parent?.scrollRow(data, at: .middle, animated: true)
            }
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
        
        if let dateRow = data as? BxInputSelectorDateRow {
            if let date = dateRow.value {
                valueTextField.text = parent?.settings.dateFormat.string(from: date)
            } else {
                valueTextField.text = ""
            }
        } else if let row = data as? BxInputStringRow {
            valueTextField.text = row.stringValue
        }
        valueTextField.placeholder = data.placeholder
        refreshOpened(animated: false)
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        valueTextField.isEnabled = value
        valueTextField.alpha = value ? 1 : 0.5
        titleLabel.alpha = value ? 1 : 0.5
        arrowImage.alpha = value ? 1 : 0.5
    }
    
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
        if animated {
            UIView.commitAnimations()
        }
    }
    
}
