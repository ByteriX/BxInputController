/**
 *	@file UIControl.swift
 *	@namespace BxInputController
 *
 *	@details UIControl extensions
 *	@date 13.09.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// UIControl extensions make working with them easaly
extension UIControl {
    
#if swift( >=4.2 )
    public typealias BxControlEvent = UIControl.Event
#else
    public typealias BxControlEvent = UIControlEvents
#endif
    
    /// remove all targets with defined action and controlEvents, then add new target if it is not null. This method optimize
    public func changeTarget(_ target: Any?, action selector: Selector, for controlEvents: BxControlEvent)
    {
        let stringSelector = NSStringFromSelector(selector)
        for targetItem in allTargets {
            
            if let actions = actions(forTarget: targetItem, forControlEvent: controlEvents)
            {
                for action in actions {
                    if action == stringSelector {
                        removeTarget(targetItem, action: selector, for: controlEvents)
                    }
                }
            }
        }
        if let target = target {
            addTarget(target, action: selector, for: controlEvents)
        }
    }
    
}
