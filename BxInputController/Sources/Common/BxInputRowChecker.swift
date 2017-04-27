/**
 *	@file BxInputRowChecker.swift
 *	@namespace BxInputController
 *
 *	@details This is checker puted values with visualization of problems with them
 *	@date 22.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// priority of checking value
public enum BxInputRowCheckerPriority {
    /// when row showed
    case immediately
    /// when user change value
    case updateValue
    /// when user go to next row or finish input
    case transitonValue
    /// programaly only
    case manualOnly
}

/// Base protocol for checking putted value for row
public protocol BxInputRowChecker : AnyObject
{
    /// decoration row when checking fail
    var decorator : BxInputRowDecorator? {get}
    
    /// Mode when checker waiting for a correction value
    /// Row can have only one active checker (this is first checker, all other should will deactivated).
    var isActivated : Bool {get set}
    
    /// priority for deactive mode, when user isn't doing active changes
    var planPriority: BxInputRowCheckerPriority {get}
    /// priority for active mode, when user is doing active changes
    var activePriority: BxInputRowCheckerPriority {get}
    
    
    /// checking method
    func isOK() -> Bool
}
