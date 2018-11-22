/**
 *    @file BxInputRowBinderMenu.swift
 *    @namespace BxInputController
 *
 *    @details Protocols for BxInputRowBinder classes with action menu realization
 *    @date 22.11.2018
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2018 ByteriX. See http://byterix.com
 */

import Foundation

/// Base protocol for action menu showing
public protocol BxInputRowBinderMenu
{}

/// Action menu item for paste
public protocol BxInputRowBinderMenuPaste : BxInputRowBinderMenu {
    var canPasteValue : Bool {get}
    func pasteValue()
}

/// Action menu item for copy
public protocol BxInputRowBinderMenuCopy : BxInputRowBinderMenu {
    var canCopyValue : Bool {get}
    func copyValue()
}

/// Action menu item for cut
public protocol BxInputRowBinderMenuCut : BxInputRowBinderMenu {
    var canCutValue : Bool {get}
    func cutValue()
}

/// Action menu item for delete
public protocol BxInputRowBinderMenuDelete : BxInputRowBinderMenu {
    var canDeleteValue : Bool {get}
    func deleteValue()
}

/// All actions for menu combined in single
public protocol BxInputRowBinderMenuAll : BxInputRowBinderMenuPaste, BxInputRowBinderMenuCopy, BxInputRowBinderMenuCut, BxInputRowBinderMenuDelete
{}

extension BxInputRowBinderMenuCopy where Self : BxInputRowBinder
{
    public var canCopyValue : Bool {
        return true
    }
}

extension BxInputRowBinderMenuPaste where Self : BxInputRowBinder
{
    public var canPasteValue : Bool {
        return rowData.isEnabled
    }
}

extension BxInputRowBinderMenuCut where Self : BxInputRowBinder
{
    public var canCutValue : Bool {
        return rowData.isEnabled
    }
}

extension BxInputRowBinderMenuDelete where Self : BxInputRowBinder
{
    public var canDeleteValue : Bool {
        return rowData.isEnabled
    }
}

/// Default realization of BxInputRowBinderMenuCut with standart behavior
extension BxInputRowBinderMenuCut where Self : BxInputRowBinder, Self : BxInputRowBinderMenuCopy, Self : BxInputRowBinderMenuDelete
{
    public func cutValue() {
        copyValue()
        deleteValue()
    }
    
    public var canCutValue : Bool {
        return canCopyValue && canDeleteValue
    }
}
