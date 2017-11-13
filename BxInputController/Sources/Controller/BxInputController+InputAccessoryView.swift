/**
 *	@file BxInputController+InputAccessoryView.swift
 *	@namespace BxInputController
 *
 *	@details Working with panel abouve keyboard in BxInputController
 *	@date 23.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Working with panel abouve keyboard in BxInputController
extension BxInputController
{
    /// Class of panel abouve keyboard
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
    
    /// refresh commonInputAccessoryView for using this as panel as abouve keyboard
    open func updateInputAccessory()
    {
        if isShowingInputAccessoryView {
            commonInputAccessoryView = InputAccessoryView(parent: self)
            updateCommonInputAccessory()
        } else {
            commonInputAccessoryView = nil
        }
    }
    
    /// update content of panel as abouve keyboard
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
    
    /// set and update panel abouve keyboard for activeControl
    open func updateInputAccessory(activeControl: UIView?)
    {
        if let activeControl = activeControl as? UITextField {
            activeControl.inputAccessoryView = commonInputAccessoryView
        } else if let activeControl = activeControl as? UITextView {
            activeControl.inputAccessoryView = commonInputAccessoryView
        }
        updateCommonInputAccessory()
    }
    
    /// event when user click back or next row
    @objc open func backNextButtonClick(control: UISegmentedControl) {
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
    
    /// event when user click done
    @objc open func doneButtonClick() {
        activeControl?.resignFirstResponder()
    }
    
    /// return true if row can get focus
    open func checkedForGettingRow(_ row: BxInputRow) -> Bool{
        if row is BxInputChildSelectorRow {
            return false
        }
        return row.isEnabled
    }
    
    /// return a row after current row. If not found then return nil
    open func getIncrementRow(from row: BxInputRow) -> BxInputRow?
    {
        if let indexPath = getIndex(for: row) {
            var sectionIndex = indexPath.section
            var rowIndex = indexPath.row + 1
            while sectionIndex < sections.count {
                let rowBinders = sections[sectionIndex].rowBinders
                while rowIndex < rowBinders.count {
                    let result = rowBinders[rowIndex].rowData
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
    
    /// return a row before current row. If not found then return nil
    open func getDecrementRow(from row: BxInputRow) -> BxInputRow?
    {
        if let indexPath = getIndex(for: row) {
            var sectionIndex = indexPath.section
            var rowIndex = indexPath.row - 1
            while sectionIndex > -1 {
                let rowBinders = sections[sectionIndex].rowBinders
                while rowIndex > -1 {
                    let result = rowBinders[rowIndex].rowData
                    if checkedForGettingRow(result) {
                        return result
                    }
                    rowIndex = rowIndex - 1
                }
                sectionIndex = sectionIndex - 1
                if sectionIndex > -1 {
                    rowIndex = sections[sectionIndex].rowBinders.count - 1
                }
            }
        }
        return nil
    }
    
}
