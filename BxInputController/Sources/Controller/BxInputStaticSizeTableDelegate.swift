//
//  BxInputStaticSizeTableDelegate.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 23/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputStaticSizeTableDelegate : BxInputBaseTableDelegate
{
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard let row = parentController?.getRow(for: indexPath) else {
            return 60
        }
        if let staticRow = row as? BxInputStaticHeight {
            return staticRow.height
        } else if let cellHeight = parentController?.settings.globalCellHeight {
            return cellHeight
        } else {
            return row.estimatedHeight
        }
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        guard let sectionData = parentController?.sections[section] else {
            return 30
        }
        
        guard let header = sectionData.header else {
            return 1
        }
        return header.estimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        guard let sectionData = parentController?.sections[section] else {
            return 0
        }
        
        guard let footer = sectionData.footer else {
            return 1
        }
        return footer.estimatedHeight
    }
    
    
}
