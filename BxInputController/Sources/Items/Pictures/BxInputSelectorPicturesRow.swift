/**
 *	@file BxInputSelectorPicturesRow.swift
 *	@namespace BxInputController
 *
 *	@details Implementation row with photos and camera selector. Selector is showed with keyboard frame
 *	@date 03.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Implementation row with photos and camera selector. Selector is showed with keyboard frame
open class BxInputSelectorPicturesRow : BxInputRow, BxInputSelectorRow
{
    open var resourceId : String {
        get { return "BxInputSelectorCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 54 }
    }
    
    open var title : String?
    public var placeholderHint: String?
    open var placeholder : String? {
        get {
            if let placeholderHint = placeholderHint {
                return "\(placeholderHint) \(pictures.count)"
            } else {
                return "\(pictures.count)"
            }
        }
    }
    open var isEnabled : Bool = true
    
    open var isOpened: Bool = false
    open var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    open var pictures: [BxInputPicture]
    open var iconSize: CGSize = CGSize(width: 64, height: 64)
    open var iconMargin: CGFloat = 8
    open var iconMode: UIViewContentMode = .scaleAspectFill
    open var countInRow: Int = 4
    open var maxSelectedCount: Int = 5
    open var isUniqueue: Bool = true
    
    
    
    public var chield : BxInputChildSelectorPicturesRow
    public var children: [BxInputChildSelectorRow] {
        get {
            return [chield]
        }
    }
    
    public init(title: String? = nil, placeholder: String? = nil, pictures: [BxInputPicture] = []) {
        self.title = title
        self.placeholderHint = placeholder
        self.pictures = pictures
        chield = BxInputChildSelectorPicturesRow()
        chield.parent = self
    }
    
}

/// Chield row for BxInputSelectorPicturesRow with picture items
open class BxInputChildSelectorPicturesRow: BxInputChildSelectorRow, BxInputStaticHeight
{
    open var resourceId : String = "BxInputSelectorPicturesCell"
    open var height : CGFloat {
        get {
            if let parent = parent as? BxInputSelectorPicturesRow {
                return parent.iconSize.height + 2 * parent.iconMargin + 2
            }
            return 75
        }
    }
    open var estimatedHeight : CGFloat {
        get { return height }
    }
    
    open var title : String? {
        get {
            return parent?.title ?? nil
        }
    }
    open var placeholder : String? {
        get {
            return parent?.placeholder ?? nil
        }
    }
    open var isEnabled : Bool {
        get {
            return parent?.isEnabled ?? false
        }
        set {
            parent?.isEnabled = isEnabled
        }
    }
    
    weak open var parent: BxInputSelectorRow? = nil
}

