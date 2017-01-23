//
//  BxInputEstimatedSizeTableDelegate.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 23/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputEstimatedSizeTableDelegate : BxInputBaseTableDelegate
{
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard let row = parentController?.getRow(for: indexPath) else {
            return 60
        }
        if let staticRow = row as? BxInputStaticHeight {
            return staticRow.height
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        guard let row = parentController?.getRow(for: indexPath) else {
            return 60
        }
        return row.estimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    {
        guard let sectionData = parentController?.sections[section] else {
            return 30
        }
        
        guard let header = sectionData.header else {
            return 10
        }
        return header.estimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    {
        guard let sectionData = parentController?.sections[section] else {
            return 0
        }
        
        guard let footer = sectionData.footer else {
            return 10
        }
        return footer.estimatedHeight
    }
    
}
