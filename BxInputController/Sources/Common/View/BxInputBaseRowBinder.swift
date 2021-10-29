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
            } else if let cell = newValue{
                assertionFailure("Error Cell class from \(type(of: self)).\nExpected: \(Cell.self) actual: \(type(of: cell)).\nThis use from row with class \(type(of: row)).")
            } else {
                self.cell = nil
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
    
    public var needChangeDisabledCell: Bool {
        return owner?.settings.isNormalShowingDisabledCell == false
    }
    
    public var alphaForDisabledView: CGFloat {
        return owner?.settings.alphaForDisabledView ?? 0.5
    }
    
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
    
    private func deacivate(for checker: BxInputRowChecker) {
        if checker.isActivated == true {
            checker.isActivated = false
            if let decorator = checker.decorator {
                //DispatchQueue.main.async { [weak self] in
                if checker.isActivated == false {
                    decorator.deactivate(binder: self)
                }
                //}
            }
            owner?.didChangeActive(for: checker)
        }
    }
    
    private func acivate(for checker: BxInputRowChecker) {
        if checker.isActivated == false {
            checker.isActivated = true
            if let decorator = checker.decorator {
                //DispatchQueue.main.async { [weak self] in
                if checker.isActivated == true {
                    decorator.activate(binder: self)
                }
                //}
            }
            owner?.didChangeActive(for: checker)
        }
    }
    
    /// Just deactivate all checker. In may need for example for retesting all rows
    public func deacivateCheckers() {
        for checker in checkers {
            deacivate(for: checker)
        }
    }
    
    /// use all added checkers with 'priority' for testing value of row
    @discardableResult
    open func planCheckRow(priority: BxInputRowCheckerPriority) -> Bool {
        // it able disactivate secondery checker
        var resultActivation : BxInputRowChecker? = nil
        for checker in checkers {
            if checker.planPriority == priority || checker.planPriority == .always || priority == .always
            {
                if resultActivation == nil {
                    if checker.isOK() == false {
                        resultActivation = checker // will activate later
                    }
                } else {
                    // deactivation all other checker
                    deacivate(for: checker)
                }
            }
        }
        // check activation
        if let checker = resultActivation {
            acivate(for: checker)
        }
        return resultActivation == nil
    }
    
    /// use only active checkers with 'priority' for testing value of row
    open func activeCheckRow(priority: BxInputRowCheckerPriority) {
        for checker in checkers {
            if checker.activePriority == priority || checker.activePriority == .always || priority == .always
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
        for checker in checkers {
            if checker.isActivated {
                checker.decorator?.update(binder: self)
            }
        }
        checkRow(priority: .updateRow)
    }
    
    /// See BxInputRowBinder
    open func didChangeValue() {
        checkRow(priority: .updateValue)
        if let row = rowData as? BxInputValueRow { // May will create new subclass of this, NO!!!
            row.didChangeValue()
            owner?.didChangeValue(for: row)
        }
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
