/**
 *	@file BxInputController+UITableViewDelegate.swift
 *	@namespace BxInputController
 *
 *	@details UITableViewDelegate implementation for BxInputController
 *	@date 24.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// UITableViewDelegate implementation for BxInputController
extension BxInputController : UITableViewDelegate{
    
    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let rowBinder = getRowBinder(for: indexPath)
        rowBinder.view = nil
    }
    
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowBinder = getRowBinder(for: indexPath)
        
        if !rowBinder.row.isEnabled {
            return
        }
        
        var isDeselect = true
        if let actionRow = rowBinder.row as? BxInputActionRow {
            isDeselect = actionRow.isImmediatelyDeselect
        }
        if isDeselect {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        rowBinder.didSelected()
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let sectionData = sections[section]
        guard let headerData = sectionData.header else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: BxInputController.emptyHeaderFooterId) as! BxInputEmptyHeaderFooterView
            return view
        }
        
        if let headerData = headerData as? BxInputSectionViewContent {
            return headerData.contentView
        } else if let headerData = headerData as? BxInputSectionNibContent {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerData.resourceId) as? BxInputBaseHeaderFooterView
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
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: BxInputController.emptyHeaderFooterId) as! BxInputEmptyHeaderFooterView
            return view
        }
        
        if let footerData = footerData as? BxInputSectionViewContent {
            return footerData.contentView
        } else if let footerData = footerData as? BxInputSectionNibContent {
            if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerData.resourceId) as? BxInputBaseHeaderFooterView
            {
                footerView.parent = self
                footerView.update(data: footerData)
                return footerView
            }
        }
        
        return nil
    }
    
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let row = getRow(for: indexPath)
        
        if let staticRow = row as? BxInputStaticHeight {
            return staticRow.height
        } else if isEstimatedContent {
            return UITableViewAutomaticDimension
        } else if let cellHeight = settings.globalCellHeight {
            return cellHeight
        } else {
            return row.estimatedHeight
        }
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let sectionData = sections[section]
        
        guard let header = sectionData.header else {
            return 1
        }
        if isEstimatedContent {
            return UITableViewAutomaticDimension
        }
        return header.estimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        let sectionData = sections[section]
        
        guard let footer = sectionData.footer else {
            return 1
        }
        if isEstimatedContent {
            return UITableViewAutomaticDimension
        }
        return footer.estimatedHeight
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
