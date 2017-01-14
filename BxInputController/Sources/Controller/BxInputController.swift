//
//  BxInputController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit
import Foundation

open class BxInputController : UIViewController
{
    open var settings: BxInputSettings = BxInputSettings.standart
    
    var tableView: UITableView = UITableView(frame: CGRect(), style: .grouped)
    var clearsSelectionOnViewWillAppear: Bool = true
    
    internal(set) var datePicker: UIDatePicker = UIDatePicker()
    internal(set) var variantsPicker: UIPickerView = UIPickerView()
    
    private var addedResources = NSMutableSet()
    internal var contentRect: CGRect = CGRect()
    
    var activeControl: UIControl? = nil
    
    var sections: [BxInputSection] = []
    {
        didSet {
            refresh()
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .date
        variantsPicker.showsSelectionIndicator = true
        
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 60
        tableView.estimatedSectionHeaderHeight = 40
        tableView.estimatedSectionFooterHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentRect = self.view.bounds
        registerKeyboardNotification()
        if clearsSelectionOnViewWillAppear,
            let indexPath = tableView.indexPathForSelectedRow
        {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterKeyboardNotification()
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.bounds
        updateInsets()
    }
    
    open func updateInsets() {
        var bottom = bottomLayoutGuide.length
        let height = self.view.frame.size.height - contentRect.size.height
        if height > bottom {
            bottom = height
        }
        tableView.contentInset = UIEdgeInsetsMake(topLayoutGuide.length, 0, bottom, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    public func checkResources(row: BxInputRow)
    {
        if !addedResources.contains(row.resourceId) {
            addedResources.add(row.resourceId)
            tableView.register(UINib(nibName: row.resourceId, bundle: nil),
                               forCellReuseIdentifier: row.resourceId)
        }
    }
    
    public func checkResources(sectionContent: BxInputSectionContent?)
    {
        guard let content = sectionContent as? BxInputSectionNibContent else {
            return
        }
        if !addedResources.contains(content.resourceId) {
            addedResources.add(content.resourceId)
            tableView.register(UINib(nibName: content.resourceId, bundle: nil),
                               forHeaderFooterViewReuseIdentifier: content.resourceId)
        }
    }
    
    public func refreshResources()
    {
        for section in sections {
            refreshSectionResources(section: section)
        }
    }
    
    public func refreshSectionResources(section: BxInputSection)
    {
        for row in section.rows {
            checkResources(row: row)
        }
        checkResources(sectionContent: section.header)
        checkResources(sectionContent: section.footer)
    }
    
    open func refresh()
    {
        refreshResources()
        tableView.reloadData()
    }
    
    open func getRow(for indexPath: IndexPath) -> BxInputRow{
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    open func getIndex(for currentRow: BxInputRow) -> IndexPath?{
        var sectionIndex = 0
        for section in sections {
            var rowIndex = 0
            for row in section.rows {
                if row === currentRow{
                    return IndexPath(row: rowIndex, section: sectionIndex)
                }
                rowIndex = rowIndex + 1
            }
            sectionIndex = sectionIndex + 1
        }
        return nil
    }
    
    open func getCell(for currentRow: BxInputRow) -> UITableViewCell?
    {
        if let indexPath = getIndex(for: currentRow) {
            return tableView.cellForRow(at: indexPath)
        }
        return nil
    }
    
    open func deselectRow(row: BxInputRow, animated: Bool = true) {
        if let indexPath = getIndex(for: row) {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    open func reloadRow(_ row: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let indexPath = getIndex(for: row) {
            tableView.reloadRows(at: [indexPath], with: animation)
            //tableView.reloadSections(IndexSet(integer: indexPath.section), with: animation)
            //tableView.reloadData()
        }
    }
    
    open func deleteRow(_ row: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let indexPath = getIndex(for: row) {
            tableView.beginUpdates()
            sections[indexPath.section].rows.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: animation)
            tableView.endUpdates()
        }
    }
    
    open func deleteRows(_ rows: [BxInputRow], with animation: UITableViewRowAnimation = .fade)
    {
        var indexes: [IndexPath] = []
        for row in rows {
            if let indexPath = getIndex(for: row) {
                indexes.append(indexPath)
            }
        }
        guard indexes.count > 0 else {
            return
        }
        indexes.sort { (first, second) -> Bool in
            return first.row > second.row
        }
        tableView.beginUpdates()
        for indexPath in indexes {
            sections[indexPath.section].rows.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: indexes, with: animation)
        tableView.endUpdates()
    }
    
    open func addRow(_ row: BxInputRow, after currentRow: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let indexPath = getIndex(for: currentRow) {
            tableView.beginUpdates()
            sections[indexPath.section].rows.insert(row, at: indexPath.row + 1)
            checkResources(row: row)
            tableView.insertRows(at: [IndexPath(row: indexPath.row + 1, section: indexPath.section)], with: animation)
            tableView.endUpdates()
        }
    }
    
    open func addRows(_ rows: [BxInputRow], after currentRow: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let currentIndexPath = getIndex(for: currentRow) {
            tableView.beginUpdates()
            var indexes: [IndexPath] = []
            var index = 1
            for row in rows {
                checkResources(row: row)
                sections[currentIndexPath.section].rows.insert(row, at: currentIndexPath.row + index)
                indexes.append(IndexPath(row: currentIndexPath.row + index, section: currentIndexPath.section))
                index = index + 1
            }
            tableView.insertRows(at: indexes, with: animation)
            tableView.endUpdates()
        }
    }
    
    open func updateRow(_ row: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let indexPath = getIndex(for: row),
            let cell = tableView.cellForRow(at: indexPath) as? BxInputStandartCell
        {
            cell.update(data: row)
        }
    }
    
    open func scrollRow(_ row: BxInputRow, at position: UITableViewScrollPosition = .middle, animated: Bool = true) {
        if let indexPath = getIndex(for: row) {
            tableView.scrollToRow(at: indexPath, at: position, animated: animated)
        }
    }
    
    open func dissmissAllRows(exclude excludeRow: BxInputRow? = nil) {
        for section in sections {
            for row in section.rows {
                if let selectorData = row as? BxInputSelectorRow,
                    selectorData.isOpened
                {
                    if selectorData === excludeRow {
                        continue
                    }
                    selectorData.isOpened = false
                    deleteRows(selectorData.children, with: .fade)
                    reloadRow(selectorData, with: .fade)
                }
            }
        }
        activeControl?.resignFirstResponder()
    }
    
    
    
}
