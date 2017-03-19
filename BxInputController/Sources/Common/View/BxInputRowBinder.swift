//
//  BxInputRowBinder.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 06/03/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

public protocol BxInputRowBinder : AnyObject {
    
    /// reference to owner
    weak var owner: BxInputController? {get set}
    /// reference to model data
    var rowData: BxInputRow {get set}
    /// view
    var viewCell: UITableViewCell? {get set}
    /// call before showing view when need update content
    func update()
    /// call when user selected this cell
    func didSelected()
    
}

open class BxInputBaseRowBinder<Row: BxInputRow, Cell : UITableViewCell> : NSObject, BxInputRowBinder
{
    /// view
    public var viewCell: UITableViewCell?
    {
        get { return cell }
        set { cell = newValue as? Cell }
    }

    /// reference to model data
    public var rowData: BxInputRow
    {
        get { return row }
        set { row = newValue as! Row }
    }

    /// reference to owner
    public weak var owner: BxInputController? = nil
    /// reference to model data
    public var row: Row
    /// view
    public weak var cell: Cell? = nil
    
    init(row: Row)
    {
        self.row = row
    }
    
    
    /// The same state of cell that isEnabled row
    public var isEnabled: Bool = true
        {
        didSet {
            didSetEnabled(isEnabled)
        }
    }
    /// update cell from model data, in inherited cell need call super!
    open func update()
    {
        self.isEnabled = row.isEnabled
        if let settings = owner?.settings {
            cell?.separatorInset = settings.separatorInset
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
    open func resignFirstResponder() -> Bool {
        if let result = cell?.resignFirstResponder() {
            return result
        }
        return false
    }
}
