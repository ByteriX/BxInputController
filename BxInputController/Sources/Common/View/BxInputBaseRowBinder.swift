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
        checkers.append(checker)
    }
    
    /// use all added checkers with 'priority' for testing value of row
    @discardableResult
    open func planCheckRow(priority: BxInputRowCheckerPriority) -> Bool {
        // it able disactivate secondery checker
        var result = true
        for checker in checkers {
            if checker.planPriority == priority || checker.planPriority == .always
            {
                if result {
                    if checker.isOK() == false {
                        checker.isActivated = true
                        if let decorator = checker.decorator {
                            DispatchQueue.main.async { [weak self] in
                                if let this = self {
                                    decorator.activate(binder: this)
                                }
                            }
                        }
                        result = false
                        owner?.didChangeActive(for: checker)
                    }
                } else {
                    if checker.isActivated {
                        checker.isActivated = false
                        if let decorator = checker.decorator {
                            DispatchQueue.main.async { [weak self] in
                                if let this = self {
                                    decorator.deactivate(binder: this)
                                }
                            }
                        }
                        owner?.didChangeActive(for: checker)
                    }
                }
            }
        }
        return result
    }
    
    /// use only active checkers with 'priority' for testing value of row
    open func activeCheckRow(priority: BxInputRowCheckerPriority) {
        for checker in checkers {
            if checker.activePriority == priority || checker.activePriority == .always
            {
                if checker.isOK() == true,
                    checker.isActivated == true
                {
                    checker.isActivated = false
                    checker.decorator?.deactivate(binder: self)
                    owner?.didChangeActive(for: checker)
                    break
                }
            }
        }
    }
    
    /// use all added checkers with 'priority' for testing value of row
    @discardableResult
    open func checkRow(priority: BxInputRowCheckerPriority) -> Bool {
        activeCheckRow(priority: priority)
        return planCheckRow(priority: priority)
    }
    
    /// Which using BxInputDependencyRowsChecker subclasses it help you with checking dependencies rows
    open func checkDependencies(with checker: BxInputRowChecker) {
        for item in checkers {
            if let dependencyChecker = item as? BxInputDependencyRowsChecker {
                for currentChecker in dependencyChecker.checkers {
                    if checker === currentChecker {
                        activeCheckRow(priority: dependencyChecker.activePriority)
                        planCheckRow(priority: dependencyChecker.planPriority)
                    }
                }
            }
        }
    }
    
    /// should be called after update row
    open func updateChecking() {
        checkRow(priority:  .updateRow)
    }
    
    /// event when value of a row was changed. It may be not current row, for example parentRow from Selector type
    open func didChangedValue(for row: BxInputValueRow) {
        checkRow(priority: .updateValue)
        row.didChangedValue()
        owner?.didChangeValue(for: row)
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
