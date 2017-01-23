//
//  BxInputController.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit
import Foundation
import BxObjC

open class BxInputController : UIViewController
{
    open var settings: BxInputSettings = BxInputSettings.standart
    
    public var tableView: UITableView = UITableView(frame: CGRect(), style: .grouped)
    public var clearsSelectionOnViewWillAppear: Bool = true
    
    // in iOS less then 10.2 have bug with estimated rows ans section content
    // it depends on change content size and reproduced from iOS 9x when inserted cells for situation when you scrolled to end
    // for fixing this case I suggested use isEstimatedContent = false, and it is default value
    // http://openradar.appspot.com/15729686
    // http://www.openradar.me/24022858
    public var isEstimatedContent: Bool = false
    {
        didSet { updateEstimatedContent() }
    }
    // This changed automatical, when changed isEstimatedContent value.
    var tableDelegate: BaseTableDelegate? = nil
    
    internal(set) public var datePicker: UIDatePicker = UIDatePicker()
    internal(set) public var variantsPicker: UIPickerView = UIPickerView()
    
    private var addedResources = NSMutableSet()
    internal(set) public var contentRect: CGRect = CGRect()
    
    internal(set) public var currentBundle: Bundle = Bundle(for: BxInputController.self)
    
    internal(set) public var activeControl: UIView? = nil
    {
        didSet {
            if let activeControl = activeControl as? UITextField {
                activeControl.inputAccessoryView = commonInputAccessoryView
            } else if let activeControl = activeControl as? UITextView {
                activeControl.inputAccessoryView = commonInputAccessoryView
            }
            updateCommonInputAccessory()
        }
    }
    internal(set) public var activeRow: BxInputRow? = nil
    
    public var sections: [BxInputSection] = []
    {
        didSet { refresh() }
    }
    
    open var isShowingInputAccessoryView: Bool = true
    {
        didSet { updateInputAccessory() }
    }
    open var commonInputAccessoryView: InputAccessoryView? = nil
    
    public static var emptyHeaderFooterId = "BxInputStandartEmptyHeaderFooter"
    open func smallView() -> UIView
    {
        return UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: CGFloat.leastNonzeroMagnitude))
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        checkResources(sectionResourceId: type(of: self).emptyHeaderFooterId)
        
        datePicker.datePickerMode = .date
        variantsPicker.showsSelectionIndicator = true
        
        //tableView.tableHeaderView = smallView() it leads to insets
        //tableView.tableFooterView = smallView() it leads to insets
        self.view.addSubview(tableView)
        
        updateEstimatedContent()
        updateInputAccessory()
        
        contentRect = self.view.bounds
        updateInsets()
        tableView.setContentOffset( CGPoint(x: 0, y: -1 * tableView.contentInset.top), animated: false)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        let extendedEdgesBounds = self.extendedEdgesBounds()
        let top = extendedEdgesBounds.origin.y - contentRect.origin.y
        tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    public func getNib(resourceId: String) -> UINib
    {
        var bundle: Bundle? = nil
        if let _ = currentBundle.path(forResource: resourceId, ofType: "nib") {
            bundle = currentBundle
        }
        return UINib(nibName: resourceId, bundle: bundle)
    }
    
    public func checkResources(row: BxInputRow)
    {
        if !addedResources.contains(row.resourceId) {
            addedResources.add(row.resourceId)
            tableView.register(getNib(resourceId: row.resourceId),
                               forCellReuseIdentifier: row.resourceId)
            
        }
    }
    
    public func checkResources(sectionResourceId: String)
    {
        if !addedResources.contains(sectionResourceId) {
            addedResources.add(sectionResourceId)
            tableView.register(getNib(resourceId: sectionResourceId),
                               forHeaderFooterViewReuseIdentifier: sectionResourceId)
        }
    }
    
    public func checkResources(sectionContent: BxInputSectionContent?)
    {
        guard let content = sectionContent as? BxInputSectionNibContent else {
            return
        }
        checkResources(sectionResourceId: content.resourceId)
    }
    
    public func refreshResources()
    {
        for section in sections {
            refreshResources(section: section)
        }
    }
    
    public func refreshResources(section: BxInputSection)
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
    
    open func updateEstimatedContent()
    {
        tableView.dataSource = self
        if isEstimatedContent {
            tableDelegate = EstimatedSizeTableDelegate(parent: self)
            
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.sectionHeaderHeight = UITableViewAutomaticDimension
            tableView.sectionFooterHeight = UITableViewAutomaticDimension
        } else {
            tableDelegate = StaticSizeTableDelegate(parent: self)
            
            tableView.rowHeight = 60
            tableView.sectionHeaderHeight = 20
            tableView.sectionFooterHeight = 5
        }
        tableView.delegate = tableDelegate
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
    
    open func getIndex(for currentSection: BxInputSection) -> Int?{
        var sectionIndex = 0
        for section in sections {
            if section === currentSection{
                return sectionIndex
            }
            sectionIndex = sectionIndex + 1
        }
        return nil
    }
    
    open func getIndex(for currentSectionContent: BxInputSectionContent) -> Int?{
        if let currentSection = currentSectionContent.parent {
            return getIndex(for: currentSection)
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
    
    // if after is nil then section will be inserted to end of the table
    open func addSection(_ section: BxInputSection, after index: Int? = nil, with animation: UITableViewRowAnimation = .bottom) {
        var insertIndex = sections.count
        if let index = index {
            insertIndex = index
        }
        refreshResources(section: section)
        tableView.beginUpdates()
        sections.insert(section, at: insertIndex)
        tableView.insertSections(IndexSet(integer: insertIndex), with: animation)
//        var indexes: [IndexPath] = []
//        var index = 0
//        for _ in section.rows {
//            indexes.append(IndexPath(row: index, section: insertIndex))
//            index = index + 1
//        }
//        tableView.insertRows(at: indexes, with: animation)
        tableView.endUpdates()
    }
    
    open func deleteSection(_ section: BxInputSection, with animation: UITableViewRowAnimation = .top) {
        guard let index = getIndex(for: section) else {
            return
        }
        tableView.beginUpdates()
        sections.remove(at: index)
        tableView.deleteSections(IndexSet(integer: index), with: animation)
        tableView.endUpdates()
    }
    
    open func updateSection(_ section: BxInputSection, with animation: UITableViewRowAnimation = .top) {
        guard let index = getIndex(for: section) else {
            return
        }
        var isNeedReloadSection = !(sections[index] === section)
        if let header = tableView.headerView(forSection: index) as? BxInputStandartHeaderFooter
        {
            if let headerData = section.header {
                header.update(data: headerData)
            } else {
                isNeedReloadSection = true
            }
        }
        if let footer = tableView.footerView(forSection: index) as? BxInputStandartHeaderFooter
        {
            if let footerData = section.footer {
                footer.update(data: footerData)
            } else {
                isNeedReloadSection = true
            }
        }
        if isNeedReloadSection {
            reloadSection(section, with: animation)
        }
    }
    
    open func reloadSection(_ section: BxInputSection, with animation: UITableViewRowAnimation = .top) {
        guard let index = getIndex(for: section) else {
            return
        }
        tableView.beginUpdates()
        sections[index] = section
        tableView.reloadSections(IndexSet(integer: index), with: animation)
        tableView.endUpdates()
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
    
    @objc internal func select(indexPath: IndexPath) {
        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
    }
    
    open func selectRow(_ row: BxInputRow, at position: UITableViewScrollPosition = .middle, animated: Bool = true)
    {
        //scrollRow(row, at: position, animated: animated)
        if let indexPath = getIndex(for: row) {
            tableView.selectRow(at: indexPath, animated: animated, scrollPosition: position)
            if let _ = tableView.cellForRow(at: indexPath) {
                select(indexPath: indexPath)
            } else {
                self.perform(#selector(select(indexPath:)), with: indexPath, afterDelay: 0.25)
            }
        }
    }
    
    open func dissmissSelectors(exclude excludeRow: BxInputRow? = nil) {
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
    }
    
    open func dissmissAllRows(exclude excludeRow: BxInputRow? = nil) {
        dissmissSelectors(exclude: excludeRow)
        activeControl?.resignFirstResponder()
        if !(activeRow === excludeRow) {
            activeRow = nil
        }
    }
    
    open func didChangedRow(_ row: BxInputRow)
    {
        // you can override
    }
    
    // recomended use it, because in row change value don't update table
    open func setEnabledRow(_ row: BxInputRow, enabled: Bool)
    {
        if row.isEnabled != enabled {
            row.isEnabled = enabled
            reloadRow(row)
        }
    }
    
}
