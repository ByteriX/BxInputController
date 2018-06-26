/**
 *    @file BxInputIconActionRow.swift
 *    @namespace BxInputController
 *
 *    @details Action row implementation with association generic class and icon
 *    @date 26.06.2018
 *    @author Sergey Balalaev
 *
 *    @version last in https://github.com/ByteriX/BxInputController.git
 *    @copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *     Copyright (c) 2018 ByteriX. See http://byterix.com
 */

import UIKit

/// Action row implementation with association generic class and icon
open class BxInputIconActionRow<T : BxInputString>: BxInputActionRow
{
    
    open var binder : BxInputRowBinder {
        return BxInputIconActionRowBinder<T, BxInputIconActionCell>(row: self)
    }
    open var resourceId = "BxInputIconActionCell"
    open var stringValue : String? {
        get { return value?.stringValue }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    // Will Showen when defined
    open var icon : UIImage?
    /// If didn't define then will be used size of UIImage
    open var iconSize : CGSize?
    open var title : String?
    /// If didn't defined then will be used settings color
    open var titleColor : UIColor?
    open var subtitle : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var value: T? = nil
    open var handler: ((_ actionRow: BxInputActionRow) -> Void)? = nil
    open var isImmediatelyDeselect: Bool = false
    
    /// Return true if value for the row is empty
    open var hasEmptyValue: Bool
    {
        return value == nil
    }
    
    public init(icon : UIImage? = nil, iconSize : CGSize? = nil,
                title: String? = nil, titleColor: UIColor? = nil,
                subtitle: String? = nil, placeholder: String? = nil, value: T? = nil) {
        self.icon = icon
        self.iconSize = iconSize
        self.title = title
        self.titleColor = titleColor
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.value = value
    }
    
    /// event when value of current row was changed
    open func didChangedValue(){
        //
    }
}
