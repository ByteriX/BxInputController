/**
 *	@file BxInputSelectorRow.swift
 *	@namespace BxInputController
 *
 *	@details Rows protocol for choosing items with special selector
 *	@date 12.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Row protocol with special selector for the owner of items rows (or single)
public protocol BxInputSelectorRow : BxInputRow
{
    
    /// state of the selector: opened/closed
    var isOpened: Bool {get set}
    
    /// children rows with items for choosing. It may have single object
    var children: [BxInputChildSelectorRow] {get}
    
    /// it may used if current selector support the autoselection for closing selector after choosing or other actions
    var timeForAutoselection: TimeInterval {get}
    
}

/// Row protocol with item for choosing from parent selector row. It shoulds be used only from parrent
public protocol BxInputChildSelectorRow : BxInputRow
{
    
    /// back link to the ower
    weak var parent: BxInputSelectorRow? {get set}
    
}

/// If selector row support choosing value from children, it should implement this protocol
public protocol BxInputParentSelectorSuggestionsRow : BxInputSelectorRow
{

    /// selected item
    var selectedChild: BxInputChildSelectorRow? {get set}
    
}


