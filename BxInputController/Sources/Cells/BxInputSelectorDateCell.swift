//
//  BxInputSelectorDateCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 12/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputSelectorDateCell: BxInputStandartCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    override func update(data: BxInputRow)
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
    }
    
    @IBAction func changeDate(_ sender: Any) {
        if let dateRow = data as? BxInputChildSelectorDateRow,
            let parentRow = dateRow.parent as? BxInputSelectorDateRow
        {
            parentRow.value = datePicker.date
            parent?.updateRow(parentRow)
            
            if parentRow.timeForAutoselection > 0.499 {
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoselection), object: nil)
                self.perform(#selector(autoselection), with: nil, afterDelay: parentRow.timeForAutoselection)
            }
        }
    }
    
    func autoselection() {
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
