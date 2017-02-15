/**
 *	@file BxInputController.swift
 *	@namespace BxInputController
 *
 *	@details Controller for input values
 *	@date 09.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import Foundation
import BxObjC

/// Controller for input values
open class BxInputController : UIViewController
{
    
    // MARK: - Fields
    
    /// settings of visual showing
    open var settings: BxInputSettings = BxInputSettings.standart
    /// current table, where showed all rows
    public var tableView: UITableView = UITableView(frame: CGRect(), style: .grouped)
    /// if you disappear controller, where selected cell, then after will back the cell will be deselected
    public var clearsSelectionOnViewWillAppear: Bool = true
    
    /// in iOS less then 10.2 have bug with estimated rows with section content
    /// it depends on change content size and reproduced from iOS 9x when inserted cells for situation when you scrolled to end
    /// for fixing this case I suggested use isEstimatedContent = false, and it is default value
    /// http://openradar.appspot.com/15729686
    /// http://www.openradar.me/24022858
    public var isEstimatedContent: Bool = false
    {
        didSet { updateEstimatedContent() }
    }
    /// this picker is used in a simple date row
    internal(set) public var datePicker: UIDatePicker = UIDatePicker()
    /// this picker is used in a simple variants row
    internal(set) public var variantsPicker: UIPickerView = UIPickerView()
    /// frame of content for inputting, if keyboard is showed then it be less then tableView
    internal(set) public var contentRect: CGRect = CGRect()
    /// activate control for current time
    internal(set) public var activeControl: UIView? = nil
    {
        didSet { updateInputAccessory(activeControl: activeControl) }
    }
    /// activate row for current time
    internal(set) public var activeRow: BxInputRow? = nil
    /// data models with rows for showing
    public var sections: [BxInputSection] = []
    {
        didSet { refresh() }
    }
    /// show the panel abouve keyboard for navigation by rows
    open var isShowingInputAccessoryView: Bool = true
    {
        didSet { updateInputAccessory() }
    }
    /// The panel abouve keyboard, not nil if isShowingInputAccessoryView = true
    open var commonInputAccessoryView: InputAccessoryView? = nil
    
    /// resourceId for the empty content od header/footer
    public static var emptyHeaderFooterId = "BxInputStandartEmptyHeaderFooter"
    /// buffer with resourceId values for registred header/foother/row
    internal var addedResources = NSMutableSet()
    
    // MARK: - Methods
    
    /// return emptyHeaderFooter. Depricated, please use emptyHeaderFooterId.
    open func smallView() -> UIView
    {
        return UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: CGFloat.leastNonzeroMagnitude))
    }
    
    // MARK: - View Controller cycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // for manual managment of scroll
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
        let offset = CGPoint(x: 0, y: -1 * tableView.contentInset.top)
        tableView.setContentOffset(offset, animated: false)
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
    
    // MARK: - updating methods
    
    /// change insets for tableView
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
    
    /// check buffer for register resources, which needed for showing content of row
    public func checkResources(row: BxInputRow)
    {
        if !addedResources.contains(row.resourceId) {
            addedResources.add(row.resourceId)
            tableView.register(BxInputUtils.getNib(resourceId: row.resourceId),
                               forCellReuseIdentifier: row.resourceId)
            
        }
    }
    
    /// check buffer for register resources, which needed for showing content of section by sectionResourceId
    public func checkResources(sectionResourceId: String)
    {
        if !addedResources.contains(sectionResourceId) {
            addedResources.add(sectionResourceId)
            tableView.register(BxInputUtils.getNib(resourceId: sectionResourceId),
                               forHeaderFooterViewReuseIdentifier: sectionResourceId)
        }
    }
    
    /// check buffer for register resources, which needed for showing content of section by BxInputSectionContent value
    public func checkResources(sectionContent: BxInputSectionContent?)
    {
        guard let content = sectionContent as? BxInputSectionNibContent else {
            return
        }
        checkResources(sectionResourceId: content.resourceId)
    }
    
    /// check all content of controller for register resources
    public func refreshResources()
    {
        for section in sections {
            refreshResources(section: section)
        }
    }
    
    /// check the section for register resources
    public func refreshResources(section: BxInputSection)
    {
        for row in section.rows {
            checkResources(row: row)
        }
        checkResources(sectionContent: section.header)
        checkResources(sectionContent: section.footer)
    }
    
    /// refresh all content of tableView
    open func refresh()
    {
        refreshResources()
        tableView.reloadData()
    }
    
    /// check size type of content for tableView
    open func updateEstimatedContent()
    {
        tableView.dataSource = self
        if isEstimatedContent {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.sectionHeaderHeight = UITableViewAutomaticDimension
            tableView.sectionFooterHeight = UITableViewAutomaticDimension
        } else {
            tableView.rowHeight = 60
            tableView.sectionHeaderHeight = 20
            tableView.sectionFooterHeight = 5
        }
        tableView.delegate = self
        tableView.reloadData()
    }
    
    // MARK: - getting methods
    
    /// return row for indexPath of cell
    open func getRow(for indexPath: IndexPath) -> BxInputRow {
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    /// return indexPath of cell for row, if row added to content (added to any sections)
    open func getIndex(for currentRow: BxInputRow) -> IndexPath? {
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
    
    /// return index of section if it found out
    open func getIndex(for currentSection: BxInputSection) -> Int? {
        var sectionIndex = 0
        for section in sections {
            if section === currentSection{
                return sectionIndex
            }
            sectionIndex = sectionIndex + 1
        }
        return nil
    }
    
    /// return index of section by its content if it found out
    open func getIndex(for currentSectionContent: BxInputSectionContent) -> Int?{
        if let currentSection = currentSectionContent.parent {
            return getIndex(for: currentSection)
        }
        return nil
    }
    
    /// return cell for row if it is shown
    open func getCell(for currentRow: BxInputRow) -> UITableViewCell?
    {
        if let indexPath = getIndex(for: currentRow) {
            return tableView.cellForRow(at: indexPath)
        }
        return nil
    }
    
    // MARK: - managment of content methods
    
    /// deselect cell for row
    open func deselectRow(_ row: BxInputRow, animated: Bool = true) {
        if let indexPath = getIndex(for: row) {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    /// full reload row
    open func reloadRow(_ row: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let indexPath = getIndex(for: row) {
            tableView.reloadRows(at: [indexPath], with: animation)
            //tableView.reloadSections(IndexSet(integer: indexPath.section), with: animation)
            //tableView.reloadData()
        }
    }
    
    /// delete row from controller
    open func deleteRow(_ row: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let indexPath = getIndex(for: row) {
            tableView.beginUpdates()
            sections[indexPath.section].rows.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: animation)
            tableView.endUpdates()
        }
    }
    
    /// delete rows from controller
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
    
    /// add row after other row to controller
    open func addRow(_ row: BxInputRow, after currentRow: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let indexPath = getIndex(for: currentRow) {
            tableView.beginUpdates()
            sections[indexPath.section].rows.insert(row, at: indexPath.row + 1)
            checkResources(row: row)
            tableView.insertRows(at: [IndexPath(row: indexPath.row + 1, section: indexPath.section)], with: animation)
            tableView.endUpdates()
        }
    }
    
    /// add rows after other row to controller
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
    
    /// add section to controller after index
    /// if index is nil then section will be inserted to end of the table
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
    
    /// delete section from controller
    open func deleteSection(_ section: BxInputSection, with animation: UITableViewRowAnimation = .top) {
        guard let index = getIndex(for: section) else {
            return
        }
        tableView.beginUpdates()
        sections.remove(at: index)
        tableView.deleteSections(IndexSet(integer: index), with: animation)
        tableView.endUpdates()
    }
    
    /// update content of section without full refreshing tableView
    open func updateSection(_ section: BxInputSection, with animation: UITableViewRowAnimation = .top) {
        guard let index = getIndex(for: section) else {
            return
        }
        var isNeedReloadSection = !(sections[index] === section)
        if let header = tableView.headerView(forSection: index) as? BxInputBaseHeaderFooter
        {
            if let headerData = section.header {
                header.update(data: headerData)
            } else {
                isNeedReloadSection = true
            }
        }
        if let footer = tableView.footerView(forSection: index) as? BxInputBaseHeaderFooter
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
    
    /// full reload content of section
    open func reloadSection(_ section: BxInputSection, with animation: UITableViewRowAnimation = .top) {
        guard let index = getIndex(for: section) else {
            return
        }
        tableView.beginUpdates()
        sections[index] = section
        tableView.reloadSections(IndexSet(integer: index), with: animation)
        tableView.endUpdates()
    }
    
    /// update only content of row, if cell is shown on the tableView
    open func updateRow(_ row: BxInputRow, with animation: UITableViewRowAnimation = .fade) {
        if let indexPath = getIndex(for: row),
            let cell = tableView.cellForRow(at: indexPath) as? BxInputBaseCell
        {
            cell.update(data: row)
        }
    }
    
    /// set enabled/disabled status for row
    /// recomended use it, because in row change value don't update table
    open func setEnabledRow(_ row: BxInputRow, enabled: Bool)
    {
        if row.isEnabled != enabled {
            row.isEnabled = enabled
            reloadRow(row)
        }
    }
    
    // MARK: - Handling methods
    
    /// scroll to row at position
    open func scrollRow(_ row: BxInputRow, at position: UITableViewScrollPosition = .middle, animated: Bool = true) {
        if let indexPath = getIndex(for: row) {
            tableView.scrollToRow(at: indexPath, at: position, animated: animated)
        }
    }
    
    @objc
    private func select(indexPath: IndexPath) {
        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
    }
    
    /// select row with scroll at position
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
    
    /// to close all rows with selector type
    /// - parameter exclude: if it not nil, then this row won't closed
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
    
    /// to close or resign all rows with any type
    /// - parameter exclude: if it not nil, then this row won't be closed or resigned
    open func dissmissAllRows(exclude excludeRow: BxInputRow? = nil) {
        dissmissSelectors(exclude: excludeRow)
        activeControl?.resignFirstResponder()
        if !(activeRow === excludeRow) {
            activeRow = nil
        }
    }
    
    // MARK: - Event methods
    
    /// event when row was changed
    open func didChangedRow(_ row: BxInputRow)
    {
        // you can override
    }
    
}
