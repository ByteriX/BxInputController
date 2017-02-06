//
//  BxInputSelectorPicturesRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 03/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputSelectorPicturesRow : BxInputRow, BxInputSelectorRow
{
    open var resourceId : String {
        get { return "BxInputSelectorCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 54 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    open var isOpened: Bool = false
    open var timeForAutoselection: TimeInterval = 0.0 // if < 0.5 then autoselection turned off
    open var pictures: [BxInputPicture]
    open var iconSize: CGSize = CGSize(width: 64, height: 64)
    open var iconMargin: CGFloat = 8
    open var countInRow: Int = 4
    open var maxSelectedCount: Int = 5
    
    
    
    public var chield : BxInputChildSelectorPicturesRow
    public var children: [BxInputChildSelectorRow] {
        get {
            return [chield]
        }
    }
    
    public init(title: String? = nil, placeholder: String? = nil, pictures: [BxInputPicture] = []) {
        self.title = title
        self.placeholder = placeholder
        self.pictures = pictures
        chield = BxInputChildSelectorPicturesRow()
        chield.parent = self
    }
    
}

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

