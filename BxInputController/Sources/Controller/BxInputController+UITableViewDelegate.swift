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
    
    open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    {
        let row = getRow(for: indexPath)
        return row.isEnabled
    }
    
    open func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    {
        let row = getRow(for: indexPath)
        if row.isEnabled {
            return indexPath
        } else {
            return nil
        }
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = getRow(for: indexPath)
        
        if !row.isEnabled {
            return
        }
        
        var isDeselect = true
        if let actionRow = row as? BxInputActionRow {
            isDeselect = actionRow.isImmediatelyDeselect
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
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: type(of: self).emptyHeaderFooterId) as! BxInputStandartEmptyHeaderFooter
            return view
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
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: type(of: self).emptyHeaderFooterId) as! BxInputStandartEmptyHeaderFooter
            return view
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
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let row = getRow(for: indexPath)
        return row.estimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    {
        let sectionData = sections[section]
        guard let header = sectionData.header else {
            return 10
        }
        return header.estimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    {
        let sectionData = sections[section]
        guard let footer = sectionData.footer else {
            return 10
        }
        return footer.estimatedHeight
    }


}
