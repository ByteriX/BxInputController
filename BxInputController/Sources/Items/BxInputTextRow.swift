//
//  BxInputTextRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

open class BxInputTextRow: BxInputStringRow
{
    open var resourceId : String {
        get { return "BxInputStandartTextCell" }
    }
    open var stringValue : String? {
        get { return value }
    }
    open var estimatedHeight : CGFloat {
        get { return 60 }
    }
    
    open var title : String?
    open var placeholder : String?
    open var isEnabled : Bool = true
    
    
    open var value: String? = nil

    public init(title: String? = nil, placeholder: String? = nil, value: String? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
    
    
    open var autocapitalizationType: UITextAutocapitalizationType = .none// UITextAutocapitalizationTypeSentences
    open var autocorrectionType: UITextAutocorrectionType = .no
    open var spellCheckingType: UITextSpellCheckingType = .no
    open var keyboardType: UIKeyboardType  = .default
    open var keyboardAppearance: UIKeyboardAppearance = .default
    //open var returnKeyType: UIReturnKeyType = .go
    open var enablesReturnKeyAutomatically: Bool = false
    open var isSecureTextEntry: Bool = false
    
    
}

extension UITextField {
    
    func update(from textRow: BxInputTextRow)
    {
        isSecureTextEntry = textRow.isSecureTextEntry
        autocapitalizationType = textRow.autocapitalizationType
        autocorrectionType = textRow.autocorrectionType
        spellCheckingType = textRow.spellCheckingType
        keyboardType = textRow.keyboardType
        keyboardAppearance = textRow.keyboardAppearance
        //returnKeyType = textRow.returnKeyType
        enablesReturnKeyAutomatically = textRow.enablesReturnKeyAutomatically
    }
}
