/**
 *	@file BxInputBaseRowChecker.swift
 *	@namespace BxInputController
 *
 *	@details Base class for checking putted value for row
 *	@date 27.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Base class for checking putted value for row
open class BxInputBaseRowChecker<Row : BxInputRow> : BxInputRowChecker
{
    
    /// decoration row when checking fail
    open var decorator: BxInputRowDecorator?
    
    /// Mode when checker waiting for a correction value
    /// Row can have only one active checker (this is first checker, all other should will deactivated).
    open var isActivated : Bool = false
    
    /// priority for deactive mode, when user isn't doing active changes
    open var planPriority: BxInputRowCheckerPriority = .transitonRow
    /// priority for active mode, when user is doing active changes
    open var activePriority: BxInputRowCheckerPriority = .updateValue
    
    public var row: Row
    
    /// Checking method. Default fail
    open func isOK() -> Bool
    {
        return false
    }
    
    /// default init with standart decorator. If you don't want decarate, please use decorator: nil
    public init(row: Row, decorator: BxInputRowDecorator? = BxInputStandartErrorRowDecorator()) {
        self.row = row
        self.decorator = decorator
    }
}
