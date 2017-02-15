//
//  BxInputSelectorSuggestionCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputSelectorSuggestionCell: BxInputBaseCell {
    
    @IBOutlet weak open var titleLabel: UILabel!

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
        if let row = data as? BxInputChildSelectorRow,
            let parentRow = row.parent as? BxInputParentSelectorSuggestionsRow
        {
            parentRow.selectedChild = row
            parentRow.isOpened = false
            parent?.deleteRows(parentRow.children)
            parent?.updateRow(parentRow)
            parent?.didChangedRow(parentRow)
        }
    }
    
    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        titleLabel.font = parent?.settings.titleFont
        titleLabel.textColor = parent?.settings.titleColor
        //
        titleLabel.text = data.title
    }
    
}
