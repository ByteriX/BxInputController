//
//  BxInputDependencyRowsChecker.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 28/04/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


/**
 *	@file BxInputDependencyRowsChecker.swift
 *	@namespace BxInputController
 *
 *	@details Base class for checking putted value for row
 *	@date 28.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation
import UIKit

/// Base class for checking putted value for row
open class BxInputDependencyRowsChecker : BxInputRowChecker
{
    
    /// decoration row when checking fail. Default is BxInputDisabledRowDecorator
    open var decorator: BxInputRowDecorator?
    
    /// Mode when checker waiting for a correction value
    /// Row can have only one active checker (this is first checker, all other should will deactivated).
    open var isActivated : Bool = false
    
    /// priority for deactive mode, when user isn't doing active changes
    open var planPriority: BxInputRowCheckerPriority = .always
    /// priority for active mode, when user is doing active changes
    open var activePriority: BxInputRowCheckerPriority = .always
    
    public var checkers: [BxInputRowChecker]
    
    /// Checking method. Default ok
    open func isOK() -> Bool
    {
        for checker in checkers {
            if checker.isOK() == false {
                return false
            }
        }
        return true
    }
    
    /// default init without decorator
    public init(checkers: [BxInputRowChecker] = [], subtitleColor : UIColor? = nil, subtitle : String? = nil) {
        self.checkers = checkers
        let decorator = BxInputDisabledRowDecorator()
        decorator.subtitleColor = subtitleColor
        decorator.subtitle = subtitle
        self.decorator = decorator
    }
}
