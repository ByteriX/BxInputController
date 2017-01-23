//
//  BxInputBaseTableDelegate.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 23/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputBaseTableDelegate : NSObject, UITableViewDelegate
{
    public weak var parentController: BxInputController? = nil
    
    init(parent: BxInputController){
        super.init()
        self.parentController = parent
    }
    
    open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    {
        guard let row = parentController?.getRow(for: indexPath) else {
            return false
        }
        return row.isEnabled
    }
    
    open func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    {
        guard let row = parentController?.getRow(for: indexPath) else {
            return nil
        }
        if row.isEnabled {
            return indexPath
        } else {
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = parentController?.getRow(for: indexPath) else {
            return
        }
        
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
        guard let sectionData = parentController?.sections[section] else {
            return nil
        }
        guard let headerData = sectionData.header else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: BxInputController.emptyHeaderFooterId) as! BxInputStandartEmptyHeaderFooter
            return view
        }
        
        if let headerData = headerData as? BxInputSectionViewContent {
            return headerData.contentView
        } else if let headerData = headerData as? BxInputSectionNibContent {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerData.resourceId) as? BxInputStandartHeaderFooter
            {
                headerView.parent = parentController
                headerView.update(data: headerData)
                return headerView
            }
        }
        
        return nil
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        guard let sectionData = parentController?.sections[section] else {
            return nil
        }
        guard let footerData = sectionData.footer else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: BxInputController.emptyHeaderFooterId) as! BxInputStandartEmptyHeaderFooter
            return view
        }
        
        if let footerData = footerData as? BxInputSectionViewContent {
            return footerData.contentView
        } else if let footerData = footerData as? BxInputSectionNibContent {
            if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerData.resourceId) as? BxInputStandartHeaderFooter
            {
                footerView.parent = parentController
                footerView.update(data: footerData)
                return footerView
            }
        }
        
        return nil
    }
    
}

