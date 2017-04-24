/**
 *	@file BxInputRowDecorator.swift
 *	@namespace BxInputController
 *
 *	@details Decoration interface for redrawing row with a correction
 *	@date 24.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Decoration interface for redrawing row with a correction
public protocol BxInputRowDecorator : AnyObject
{
    
    func mark(binder: BxInputRowBinder)
    
    func activation(binder: BxInputRowBinder)
}
