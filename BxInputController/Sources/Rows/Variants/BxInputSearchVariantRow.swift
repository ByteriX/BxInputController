/**
 *    @file BxInputSearchVariantRow.swift
 *    @namespace BxInputController
 *
 *    @details Selector Row for choosing one item from variants with searching
 *    @date 10.01.2019
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2019 ByteriX. See http://byterix.com
 */

import UIKit

/// Selector Row for choosing one item from variants with searching field and selector below this row
/// - parameter: T - is associated data model for variant rows, should be inherited from BxInputStringObject
open class BxInputSearchVariantRow<T: BxInputStringObject> : BxInputSelectorVariantRow<T>
{
    override open var resourceId : String {
        get { return "BxInputSearchSelectorCell" }
    }
    
    /// If you have synchronized model (for example faster DB) you can define this for updating variants
    open var searchHandler: ((_ row: BxInputSearchVariantRow, _ text: String) -> [T])? = nil
    
    /// Make and return Binder for binding row with cell.
    override open var binder : BxInputRowBinder {
        return BxInputSearchVariantRowBinder<T, BxInputSearchVariantRow<T>, BxInputSelectorCell>(row: self)
    }
    
    override public init(title: String? = nil, subtitle: String? = nil,
                         placeholder: String? = nil, value: T? = nil)
    {
        super.init(title: title, subtitle: subtitle, placeholder: placeholder, value: value)
        child = BxInputChildSearchVariantRow<T>()
        child.parent = self
        isFirstShownSelect = false
    }
    
}

/// Child Row which show variant selector below parent row
open class BxInputChildSearchVariantRow<T: BxInputStringObject>: BxInputChildSelectorVariantRow<T>
{
    // in a future UIViewTableCell will has preloader
    //open var resourceId : String = "BxInputChildSearchVariantCell"
}
