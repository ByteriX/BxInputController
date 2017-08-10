/**
 *	@file BxInputTextSettings.swift
 *	@namespace BxInputController
 *
 *	@details Settings of text putting for text rows
 *	@date 10.08.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit


/// Settings of text putting for text rows
public struct BxInputTextSettings
{
    /// it is default for all rows
    public static var standart = BxInputTextSettings()
    
    // MARK: - Values
    
    public var autocapitalizationType: UITextAutocapitalizationType = .none// UITextAutocapitalizationTypeSentences
    public var autocorrectionType: UITextAutocorrectionType = .no
    public var spellCheckingType: UITextSpellCheckingType = .no
    public var keyboardType: UIKeyboardType  = .default
    public var keyboardAppearance: UIKeyboardAppearance = .default
    public var returnKeyType: UIReturnKeyType = .default
    public var enablesReturnKeyAutomatically: Bool = false
    public var isSecureTextEntry: Bool = false
}

extension UITextField {
    
    /// update field from BxInputTextSettings attributes
    func update(from settings: BxInputTextSettings)
    {
        isSecureTextEntry = settings.isSecureTextEntry
        autocapitalizationType = settings.autocapitalizationType
        autocorrectionType = settings.autocorrectionType
        spellCheckingType = settings.spellCheckingType
        keyboardType = settings.keyboardType
        keyboardAppearance = settings.keyboardAppearance
        returnKeyType = settings.returnKeyType
        enablesReturnKeyAutomatically = settings.enablesReturnKeyAutomatically
    }
}

extension UITextView {
    
    /// update view from BxInputTextSettings attributes
    func update(from settings: BxInputTextSettings)
    {
        isSecureTextEntry = settings.isSecureTextEntry
        autocapitalizationType = settings.autocapitalizationType
        autocorrectionType = settings.autocorrectionType
        spellCheckingType = settings.spellCheckingType
        keyboardType = settings.keyboardType
        keyboardAppearance = settings.keyboardAppearance
        returnKeyType = settings.returnKeyType
        enablesReturnKeyAutomatically = settings.enablesReturnKeyAutomatically
    }
}
