//
//  BxInputSelectorSuggestionsRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 12/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation


class BxInputSelectorSuggestionsRow : BxInputStringRow, BxInputSelectorRow
{
    
    var resourceId = "BxInputSelectorCell"
    
    var title : String?
    var placeholder : String?
    var isEnabled : Bool = true
    var stringValue: String? {
        get {
            if let item = value as? BxInputStringRow {
                return item.stringValue
            }
            return nil
        }
    }
    
    var value: BxInputChildSelectorRow? = nil
    var isOpened: Bool = false
    var children: [BxInputChildSelectorRow] = []
    {
        didSet {
            for chield in children {
                chield.parent = self
            }
        }
    }
    
    init(title: String? = nil, placeholder: String? = nil) {
        self.title = title
        self.placeholder = placeholder
    }
    
}

class BxInputSelectorSuggestionsItemRow: BxInputStringRow, BxInputChildSelectorRow
{
    var resourceId = "BxInputSelectorSuggestionCell"
    
    var title : String?
    var placeholder : String?
    var isEnabled : Bool {
        get {
            return parent?.isEnabled ?? false
        }
    }
    var stringValue: String? {
        get {
            return title
        }
    }
    
    weak var parent: BxInputSelectorRow? = nil
    
    init(title: String? = nil, placeholder: String? = nil) {
        self.title = title
        self.placeholder = placeholder
    }
}
