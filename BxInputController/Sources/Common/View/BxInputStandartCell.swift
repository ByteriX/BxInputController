/**
 *	@file BxInputStandartCell.swift
 *	@namespace BxInputController
 *
 *	@details Base cell for all rows
 *	@date 09.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Base cell for all rows
open class BxInputStandartCell: UITableViewCell {
    
    /// reference to owner
    public weak var parent: BxInputController? = nil
    /// reference to model data
    public var data: BxInputRow? = nil
    /// The same state of cell that isEnabled row
    public var isEnabled: Bool = true
    {
        didSet {
            didSetEnabled(isEnabled)
        }
    }
    /// update cell from model data, in inherited cell need call super!
    open func update(data: BxInputRow)
    {
        self.data = data
        self.isEnabled = data.isEnabled
        if let settings = parent?.settings {
            separatorInset = settings.separatorInset
        }
    }
    /// call when user selected this cell
    open func didSelected()
    {
        // empty
    }
    /// event of change isEnabled
    open func didSetEnabled(_ value: Bool)
    {
        // empty
    }
    
    /// this for dismiss keybord if it was showing for this cell
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        return false
    }
    
}
