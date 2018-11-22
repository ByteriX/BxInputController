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
    func pasteValue()
}

/// Action menu item for copy
public protocol BxInputRowBinderMenuCopy : BxInputRowBinderMenu {
    func copyValue()
}

/// Action menu item for cut
public protocol BxInputRowBinderMenuCut : BxInputRowBinderMenu {
    func cutValue()
}

/// Action menu item for delete
public protocol BxInputRowBinderMenuDelete : BxInputRowBinderMenu {
    func deleteValue()
}

/// All actions for menu combined in single
public protocol BxInputRowBinderMenuAll : BxInputRowBinderMenuPaste, BxInputRowBinderMenuCopy, BxInputRowBinderMenuCut, BxInputRowBinderMenuDelete
{}

/// Default realization of BxInputRowBinderMenuCut with standart behavior
extension BxInputRowBinderMenuCut where Self : BxInputRowBinder, Self : BxInputRowBinderMenuCopy, Self : BxInputRowBinderMenuDelete
{
    public func cutValue() {
        copyValue()
        deleteValue()
    }
}
