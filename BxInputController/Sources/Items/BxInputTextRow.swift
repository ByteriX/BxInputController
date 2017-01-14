//
//  BxInputTextRow.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

class BxInputTextRow: BxInputStringRow
{
    var resourceId = "BxInputStandartTextCell"
    
    var title : String?
    var placeholder : String?
    var isEnabled : Bool = true
    var stringValue : String? {
        get {
            return value
        }
    }
    
    var value: String? = nil

    init(title: String? = nil, placeholder: String? = nil, value: String? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
    }
    
    
    
    var autocapitalizationType: UITextAutocapitalizationType = .none// UITextAutocapitalizationTypeSentences
    var autocorrectionType: UITextAutocorrectionType = .no
    var spellCheckingType: UITextSpellCheckingType = .no
    var keyboardType: UIKeyboardType  = .default
    var keyboardAppearance: UIKeyboardAppearance = .default
    //var returnKeyType: UIReturnKeyType = .go
    var enablesReturnKeyAutomatically: Bool = false
    var isSecureTextEntry: Bool = false
    
    
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
