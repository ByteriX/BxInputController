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
    
//    open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    {
//        let rowBinder = getRowBinder(for: indexPath)
//        rowBinder.view = nil
//    }
    
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
        
        if !rowBinder.rowData.isEnabled {
            return
        }
        // TODO: this need move to ActionRowBuilder:
        var isDeselect = true
        if let actionRow = rowBinder.rowData as? BxInputActionRow {
            isDeselect = actionRow.isImmediatelyDeselect
        }
        if isDeselect {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        rowBinder.didSelected()
    }
    
    open func getFooterHeader(from contentBinder: BxInputSectionContentBinder?) -> UIView?
    {
        guard let contentBinder = contentBinder else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: BxInputController.emptyHeaderFooterId)
            return view
        }
        
        var result: UIView? = nil
        
        if let headerData = contentBinder.contentData as? BxInputSectionViewContent {
            result = headerData.view
            
        } else if let headerData = contentBinder.contentData as? BxInputSectionNibContent {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerData.resourceId)
            {
                result = headerView
            }
        }
        contentBinder.contentView = result
        contentBinder.owner = self
        if result != nil {
            contentBinder.update()
        }
        return result
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let sectionData = sections[section]
        return getFooterHeader(from: sectionData.headerBinder)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let sectionData = sections[section]
        return getFooterHeader(from: sectionData.footerBinder)
    }
    
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let row = getRow(for: indexPath)
        
        if let staticRow = row as? BxInputStaticHeight {
            return staticRow.height
        } else if isEstimatedContent {
            return UITableViewAutomaticDimension
        } else if let height = settings.cellHeight {
            return height
        } else {
            return row.estimatedHeight
        }
    }
    
    public enum SectionContentType: Int {
        case footer
        case header
    }
    
    open func getFooterHeaderHeight(from content: BxInputSectionContent?, type: SectionContentType) -> CGFloat
    {
        guard let content = content else {
            return 1
        }
        if isEstimatedContent {
            return UITableViewAutomaticDimension
        }
        if type == .header {
            if let height = settings.headerHeight {
                return height
            }
        } else if type == .footer {
            if let height = settings.footerHeight {
                return height
            }
        }
        return content.estimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let sectionData = sections[section]
        return getFooterHeaderHeight(from: sectionData.header, type: .header)
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        let sectionData = sections[section]
        return getFooterHeaderHeight(from: sectionData.footer, type: .footer)
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let row = getRow(for: indexPath)
        return row.estimatedHeight
    }
    
    open func getFooterHeaderEstimatedHeight(from content: BxInputSectionContent?) -> CGFloat
    {
        guard let content = content else {
            return 10
        }
        return content.estimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    {
        let sectionData = sections[section]
        return getFooterHeaderEstimatedHeight(from: sectionData.header)
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    {
        let sectionData = sections[section]
        return getFooterHeaderEstimatedHeight(from: sectionData.footer)
    }
    
    
}
