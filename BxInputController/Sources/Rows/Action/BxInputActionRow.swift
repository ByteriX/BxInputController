/**
 *	@file BxInputActionRow.swift
 *	@namespace BxInputController
 *
 *	@details Protocol is used for provide user action with a row
 *	@date 11.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Protocol is used for provide user action with a row
public protocol BxInputActionRow: BxInputValueRow, BxInputString
{
    // TODO: Please remove BxInputValueRow & BxInputString I think it is redundant
    // TODO: it is bad BxInputActionRow in handler!!! let it remove
    
    /// action block
    var handler: ((_ actionRow: BxInputActionRow) -> Void)? {get}
    
    /// Is used for visual deselect after handling an action
    var isImmediatelyDeselect: Bool {get}
}
