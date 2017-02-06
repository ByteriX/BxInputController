//
//  BxInputController+InputAccessoryView.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 23/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

extension BxInputController
{
    open class InputAccessoryView : UIToolbar
    {
        internal(set) public var backNextControl: UISegmentedControl
        internal(set) public var doneButtonItem: UIBarButtonItem
        
        init(parent: BxInputController) {
            var items : [String] = []
            let settings = parent.settings
            items.append(settings.backButtonTitle)
            items.append(settings.nextButtonTitle)
            backNextControl = UISegmentedControl(items: items)
            backNextControl.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
            backNextControl.isMomentary = true
            backNextControl.addTarget(parent, action: #selector(backNextButtonClick), for: .valueChanged)
            
            doneButtonItem = UIBarButtonItem(title: settings.doneButtonTitle, style: .done, target: parent, action: #selector(doneButtonClick))
            
            super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 44))

            self.barStyle = .blackTranslucent
            self.items = [UIBarButtonItem(customView: backNextControl), UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButtonItem]
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    open func updateInputAccessory()
    {
        if isShowingInputAccessoryView {
            commonInputAccessoryView = InputAccessoryView(parent: self)
            updateCommonInputAccessory()
        } else {
            commonInputAccessoryView = nil
        }
    }
    
    open func updateCommonInputAccessory()
    {
        guard let commonInputAccessoryView = commonInputAccessoryView,
            let activeRow = activeRow else
        {
            return
        }
        commonInputAccessoryView.backNextControl.setEnabled(getDecrementRow(from: activeRow) != nil, forSegmentAt: 0)
        commonInputAccessoryView.backNextControl.setEnabled(getIncrementRow(from: activeRow) != nil, forSegmentAt: 1)
    }
    
    open func backNextButtonClick(control: UISegmentedControl) {
        guard let activeRow = activeRow else {
            activeControl?.resignFirstResponder()
            return
        }
        var row: BxInputRow? = nil
        if control.selectedSegmentIndex == 0 {
            row = getDecrementRow(from: activeRow)
        } else {
            row = getIncrementRow(from: activeRow)
        }
        if let row = row {
            //
            DispatchQueue.main.async {[weak self] () in
                self?.selectRow(row)
                self?.updateCommonInputAccessory()
            }
        } else {
            activeControl?.resignFirstResponder()
        }
    }
    
    open func doneButtonClick() {
        activeControl?.resignFirstResponder()
    }
    
    open func checkedForGettingRow(_ row: BxInputRow) -> Bool{
        if row is BxInputChildSelectorRow {
            return false
        }
        return row.isEnabled
    }
    
    open func getIncrementRow(from row: BxInputRow) -> BxInputRow?
    {
        if let indexPath = getIndex(for: row) {
            var sectionIndex = indexPath.section
            var rowIndex = indexPath.row + 1
            while sectionIndex < sections.count {
                let rows = sections[sectionIndex].rows
                while rowIndex < rows.count {
                    let result = rows[rowIndex]
                    if checkedForGettingRow(result) {
                        return result
                    }
                    rowIndex = rowIndex + 1
                }
                rowIndex = 0
                sectionIndex = sectionIndex + 1
            }
        }
        return nil
    }
    
    open func getDecrementRow(from row: BxInputRow) -> BxInputRow?
    {
        if let indexPath = getIndex(for: row) {
            var sectionIndex = indexPath.section
            var rowIndex = indexPath.row - 1
            while sectionIndex > -1 {
                let rows = sections[sectionIndex].rows
                while rowIndex > -1 {
                    let result = rows[rowIndex]
                    if checkedForGettingRow(result) {
                        return result
                    }
                    rowIndex = rowIndex - 1
                }
                sectionIndex = sectionIndex - 1
                if sectionIndex > -1 {
                    rowIndex = sections[sectionIndex].rows.count - 1
                }
            }
        }
        return nil
    }
    
}
