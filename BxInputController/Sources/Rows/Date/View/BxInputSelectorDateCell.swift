/**
 *	@file BxInputSelectorDateCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell with date selector. Use as child for BxInputSelectorDateRow
 *	@date 12.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Cell with date selector. Use as child for BxInputSelectorDateRow
open class BxInputSelectorDateCell: BxInputBaseCell {

    @IBOutlet weak open var datePicker: UIDatePicker!
    
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        if let dateRow = data as? BxInputChildSelectorDateRow,
            let parentRow = dateRow.parent as? BxInputSelectorDateRow
        {
            datePicker.minimumDate = parentRow.minimumDate
            datePicker.maximumDate = parentRow.maximumDate
            if let date = parentRow.value {
                datePicker.setDate(date, animated: false)
            } else {
                datePicker.setDate(Date(), animated: false)
            }
        }
        DispatchQueue.main.async { [weak self] () -> Void in
            if let datePicker = self?.datePicker {
                self?.changeDate(datePicker)
            }
        }
    }
    
    override open func didSetEnabled(_ value: Bool)
    {
        super.didSetEnabled(value)
        datePicker.isEnabled = value
        datePicker.isUserInteractionEnabled = value
        datePicker.alpha = value ? 1.0 : 0.5
    }
    
    @IBAction open func changeDate(_ sender: Any) {
        if let dateRow = data as? BxInputChildSelectorDateRow,
            let parentRow = dateRow.parent as? BxInputSelectorDateRow
        {
            parentRow.value = datePicker.date
            parent?.updateRow(parentRow)
            parent?.didChangedRow(parentRow)
            
            if parentRow.timeForAutoselection > 0.499 {
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoselection), object: nil)
                self.perform(#selector(autoselection), with: nil, afterDelay: parentRow.timeForAutoselection)
            }
        }
    }
    
    open func autoselection() {
        if let dateRow = data as? BxInputChildSelectorDateRow,
            let parentRow = dateRow.parent
        {
            if parentRow.isOpened {
                parentRow.isOpened = false
                parent?.deleteRow(dateRow)
                parent?.updateRow(parentRow)
            }
        }
    }
}
