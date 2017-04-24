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

public enum BxInputRowCheckerPriority {
    case immediately
    case transiton
}

public protocol BxInputRowChecker : AnyObject
{
    var decorator : BxInputRowDecorator? {get}
    
    var planPriority: BxInputRowCheckerPriority {get}
    var activePriority: BxInputRowCheckerPriority {get}
    
    var isActivated : Bool {get set}
    
    func isOK(row: BxInputRow) -> Bool
}

open class BxInputBaseRowChecker : BxInputRowChecker
{

    open var decorator: BxInputRowDecorator? = BxInputStandartErrorRowDecorator()
    
    open var planPriority: BxInputRowCheckerPriority = .transiton
    open var activePriority: BxInputRowCheckerPriority = .immediately
    
    open var isActivated : Bool = false
    
    public func isOK(row: BxInputRow) -> Bool
    {
        return false
    }
    
    init(message: String? = nil) {
        let decorator = BxInputStandartErrorRowDecorator()
        decorator.markPlaceholder = message
        self.decorator = decorator
    }
}
