/**
 *    @file BxInputController+Checker.swift
 *    @namespace BxInputController
 *
 *    @details BxInputController extension for checker
 *    @date 06.11.2018
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2018 ByteriX. See http://byterix.com
 */

import Foundation

/// BxInputController extension for checker
extension BxInputController {
    
    /// add to row checker. The sequence is important for activation. First rights
    open func addChecker(_ checker: BxInputRowChecker, for row: BxInputRow)
    {
        if let binder = getRowBinder(for: row) {
            binder.addChecker(checker)
            if let _ = checker as? BxInputDependencyRowsChecker {
                dependencyCheckerBinders.append(binder)
            }
        } else {
            assert(false, "row not found for checker")
        }
    }
    
    /// check row and return result of checking
    /// param willSelect - if it is true and checking fail then this row will be selected immediately. Default is false
    @discardableResult
    open func checkRow(_ row: BxInputRow, willSelect: Bool = false) -> Bool {
        var result = false
        if let rowBinder = getRowBinder(for: row) {
            result = rowBinder.checkRow(priority: .always)
        } else {
            assert(false, "row not found for checker")
        }
        if willSelect && result == false {
            selectRow(row)
        }
        return result
    }
    
    /// check all rows in section and return result of checking
    /// param willSelect - if it is true and checking fail for a row then this first row will be selected immediately. Default is false
    @discardableResult
    open func checkSection(_ section: BxInputSection, willSelect: Bool = false) -> Bool {
        var result = true
        for rowBinder in section.rowBinders {
            if !rowBinder.checkRow(priority: .always) {
                if willSelect && result {
                    selectRow(rowBinder.rowData)
                }
                result = false
            }
        }
        return result
    }
    
    /// check all rows in table and return result of checking
    /// param willSelect - if it is true and checking fail for a row then this first row will be selected immediately. Default is false
    @discardableResult
    open func checkAllRows(willSelect: Bool = false) -> Bool {
        deactivateAllRowsCheckers()
        var result = true
        for section in sections {
            if !checkSection(section, willSelect: willSelect && result) {
                result = false
            }
        }
        return result
    }
    
    /// deactivate all decorator for checkers of row
    open func deactivateRowCheckers(_ row: BxInputRow) {
        if let rowBinder = getRowBinder(for: row) {
            rowBinder.deacivateCheckers()
        } else {
            assert(false, "row not found for checker")
        }
    }
    
    /// deactivate all decorator for checkers of section
    open func deactivateSectionCheckers(_ section: BxInputSection) {
        for rowBinder in section.rowBinders {
            rowBinder.deacivateCheckers()
        }
    }
    
    /// deactivate all decorator for checkers of all rows
    open func deactivateAllRowsCheckers() {
        for section in sections {
            deactivateSectionCheckers(section)
        }
    }
    
}
