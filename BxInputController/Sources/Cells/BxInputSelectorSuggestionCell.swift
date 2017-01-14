//
//  BxInputSelectorSuggestionCell.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 13/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputSelectorSuggestionCell: BxInputStandartCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func didSelected()
    {
        super.didSelected()
        if data?.isEnabled ?? true {
            if let row = data as? BxInputSelectorSuggestionsItemRow,
                let parentRow = row.parent as? BxInputSelectorSuggestionsRow
            {
                parentRow.value = row
                parentRow.isOpened = false
                parent?.deleteRows(parentRow.children)
                parent?.updateRow(parentRow)
            }
        }
    }
    
    override func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        titleLabel.font = parent?.settings.titleFont
        titleLabel.textColor = parent?.settings.titleColor
        //
        titleLabel.text = data.title
    }
    
}
