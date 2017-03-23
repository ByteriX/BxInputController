/**
 *	@file BxInputChildSelectorSuggestionsRow.swift
 *	@namespace BxInputController
 *
 *	@details Child row for showing suggestion from BxInputSelectorSuggestionsRow
 *	@date 15.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Child row for showing suggestion from BxInputSelectorSuggestionsRow
open class BxInputChildSelectorSuggestionsRow: BxInputRow, BxInputString, BxInputChildSelectorRow
{
    /// Make and return Binder for binding row with cell.
    open var binder : BxInputRowBinder {
        return BxInputChildSelectorSuggestionRowBinder<BxInputChildSelectorSuggestionsRow, BxInputChildSelectorSuggestionCell>(row: self)
    }
    open var resourceId : String {
        get { return "BxInputChildSelectorSuggestionCell" }
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
        set {
            parent?.isEnabled = isEnabled
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
