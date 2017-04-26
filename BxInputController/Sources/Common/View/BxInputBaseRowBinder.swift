/**
 *	@file BxInputBaseRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Base class for binding row data model with cell
 *	@date 25.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Base class for binding row data model with cell
open class BxInputBaseRowBinder<Row: BxInputRow, Cell : UITableViewCell> : NSObject, BxInputRowBinder
{
    
    /// view for internal using
    public var viewCell: UITableViewCell?
        {
        get { return cell }
        set {
            if let cell = newValue as? Cell {
                self.cell = cell
            } else {
                if let cell = newValue{
                    assertionFailure("Error Cell class from \(type(of: self)).\nExpected: \(Cell.self) actual: \(type(of: cell)).\nThis use from row with class \(type(of: row)).")
                } else {
                    assertionFailure("Error from \(type(of: self)) get nil cell from tableView.\nThis use from row with class \(type(of: row))")
                }
            }
        }
    }
    
    /// reference to model data
    public var rowData: BxInputRow
        {
        get { return row }
        set {
            if let row = newValue as? Row {
                self.row = row
            } else {
                assertionFailure("Error Row class from \(type(of: self)).\nExpected: \(Row.self) actual: \(type(of: newValue)).")
            }
        }
    }
    
    /// reference to owner
    public weak var owner: BxInputController? = nil
    /// reference to model data
    public var row: Row
    /// view
    public weak var cell: Cell? = nil
    
    public var checkers: [BxInputRowChecker] = []
    
    /// new value should map with data model
    public init(row: Row)
    {
        self.row = row
    }
    
    
    /// The same state of cell that isEnabled row
    public var isEnabled: Bool = true
        {
        didSet {
            didSetEnabled(isEnabled)
        }
    }
    /// update cell from model data, in inherited cell need call super!
    open func update()
    {
        self.isEnabled = row.isEnabled
        if let settings = owner?.settings {
            cell?.separatorInset = settings.separatorInset
        }
    }
    /// call when user selected this cell
    open func didSelected()
    {
        // empty
    }
    /// event of change isEnabled
    open func didSetEnabled(_ value: Bool)
    {
        // empty
    }

    /// add to row checker. The sequence is important for activation. First rights
    open func addChecker(_ checker: BxInputRowChecker)
    {
        if let checker = checker as? BxInputRowChecker {
            checkers.append(checker)
        } else {
            assertionFailure("Error Checker class from \(type(of: self)).\nExpected: \(Row.self) actual: \(type(of: checker)).")
        }
    }
    
    /// use all added checkers with 'priority' for testing value of row
    open func planCheckRow(priority: BxInputRowCheckerPriority) {
        // it able disactivate secondery checker
        var isFoundFirst = false
        for checker in checkers {
            if checker.planPriority == priority {
                if isFoundFirst {
                    checker.isActivated = false
                    update()
                } else {
                    if let decorator = checker.decorator, checker.isOK(row: row) == false {
                        checker.isActivated = true
                        DispatchQueue.main.async { [weak self] in
                            if let this = self {
                                decorator.activate(binder: this)
                            }
                        }
                        isFoundFirst = true
                    }
                }
            }
        }
    }
    
    /// use only active checkers with 'priority' for testing value of row
    open func activeCheckRow(priority: BxInputRowCheckerPriority) {
        for checker in checkers {
            if checker.activePriority == priority, checker.isActivated {
                if checker.isOK(row: row) == true {
                    checker.isActivated = false
                    update()
                    break
                }
            }
        }
    }
    
    /// use all added checkers with 'priority' for testing value of row
    open func checkRow(priority: BxInputRowCheckerPriority) {
        activeCheckRow(priority: priority)
        planCheckRow(priority: priority)
    }
    
    /// should be called after update row
    open func updateChecking() {
        for checker in checkers {
            if checker.isOK(row: row) == false {
                if checker.planPriority == .immediately {
                    checker.isActivated = true
                }
                if let decorator = checker.decorator, checker.isActivated {
                    DispatchQueue.main.async { [weak self] in
                        if let this = self {
                            decorator.update(binder: this)
                        }
                    }
                    break
                }
            }
        }
    }
    
    /// event when value of a row was changed. It may be not current row, for example parentRow from Selector type
    open func didChangedValue(for row: BxInputValueRow) {
        checkRow(priority: .updateValue)
        row.didChangedValue()
        owner?.didChangedValue(for: row)
    }
    
    /// this for dismiss keybord if it was showing for this cell
    @discardableResult
    open func resignFirstResponder() -> Bool {
        if let result = cell?.resignFirstResponder() {
            return result
        }
        return false
    }
}
