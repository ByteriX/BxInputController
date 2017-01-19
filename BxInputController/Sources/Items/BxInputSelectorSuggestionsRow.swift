//
//  BxInputSelectorSuggestionsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 12/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputSelectorSuggestionsRow<T : BxInputChildSelectorRow> : BxInputStringRow, BxInputParentSelectorSuggestionsRow
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
    open var stringValue: String? {
        get {
            if let item = selectedChild {
                if let item = selectedChild as? BxInputStringRow {
                    return item.stringValue
                } else {
                    return item.title
                }
            }
            return nil
        }
    }
    open var isOpened: Bool = false
    
    open var value: T? {
        get { return selectedChild as? T}
        set { selectedChild = value}
    }
    public var selectedChild: BxInputChildSelectorRow? = nil
    internal(set) public var children: [BxInputChildSelectorRow]
    {
        didSet {
            for chield in children {
                chield.parent = self
            }
        }
    }
    
    public init(title: String? = nil, placeholder: String? = nil, children: [T] = []) {
        self.title = title
        self.placeholder = placeholder
        self.children = children
    }
    
    open func setChildren(_ children: [T]) {
        self.children = children
    }
    
}

open class BxInputSelectorSuggestionsItemRow: BxInputStringRow, BxInputChildSelectorRow
{
    
    open var resourceId : String {
        get { return "BxInputSelectorSuggestionCell" }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool {
        get {
            return parent?.isEnabled ?? false
        }
    }
    open var stringValue: String? {
        get {
            return title
        }
    }
    
    weak open var parent: BxInputSelectorRow? = nil
    
    public init(title: String? = nil, placeholder: String? = nil) {
        self.title = title
        self.placeholder = placeholder
    }
}
