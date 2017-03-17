/**
 *	@file BxInputVariantsRow.swift
 *	@namespace BxInputController
 *
 *	@details Row for choosing one item from variants from selector with keyboard frame
 *	@date 10.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Row for choosing one item from variants from selector with keyboard frame
/// - parameter: T - is associated data model for variants rows, should be inherited from BxInputStringObject
open class BxInputVariantsRow<T : BxInputStringObject> : BxInputRow, BxInputVariants
{
    
    /// Make and return Binder for binding row with cell.
    open var binder : BxInputRowBinder {
        return BxInputVariantsRowBinder<T, BxInputStandartTextCell>(row: self)
    }
    
    open var resourceId : String {
        get { return "BxInputStandartTextCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var items: [T] = []
    open var value: T?
    
    internal var variants: [BxInputStringObject] {
        get { return items }
    }
    internal var selectedVariant: BxInputStringObject? {
        get { return value }
        set(value) {
            if let value = value as? T {
                self.value = value
            } else {
                self.value = nil
            }
        }
    }
    
    public init(title: String? = nil, placeholder: String? = nil, value: T? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
}

