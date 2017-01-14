//
//  BxInputController+UITableViewDelegate.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 14/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


extension BxInputController : UITableViewDelegate
{

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = getRow(for: indexPath)
        
        if !row.isEnabled {
            return
        }
        
        var isDeselect = true
        if let actionRow = row as? BxInputActionRow {
            isDeselect = actionRow.isAutomaticDeselect
        }
        if isDeselect {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? BxInputStandartCell {
            cell.didSelected()
        }
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let sectionData = sections[section]
        guard let headerData = sectionData.header else {
            return nil
        }
        
        if let headerData = headerData as? BxInputSectionViewContent {
            return headerData.contentView
        } else if let headerData = headerData as? BxInputSectionNibContent {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerData.resourceId) as? BxInputStandartHeaderFooter
            {
                headerView.parent = self
                headerView.update(data: headerData)
                return headerView
            }
        }
        
        return nil
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let sectionData = sections[section]
        guard let footerData = sectionData.footer else {
            return nil
        }
        
        if let footerData = footerData as? BxInputSectionViewContent {
            return footerData.contentView
        } else if let footerData = footerData as? BxInputSectionNibContent {
            if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerData.resourceId) as? BxInputStandartHeaderFooter
            {
                footerView.parent = self
                footerView.update(data: footerData)
                return footerView
            }
        }
        
        return nil
    }

}
