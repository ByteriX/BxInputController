/**
 *	@file BxInputFormattedTextRow.swift
 *	@namespace BxInputController
 *
 *	@details Text row for putting a Formatted value, for example phone
 *	@date 14.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Text row for putting a Formatted value, for example phone
open class BxInputFormattedTextRow: BxInputTextRow
{
    /// Make and return Binder for binding row with cell.
    override open var binder : BxInputRowBinder {
        return BxInputFormattedTextRowBinder<BxInputFormattedTextRow, BxInputFormattedTextCell>(row: self)
    }
    override open var resourceId : String {
        get { return "BxInputFormattedTextCell" }
    }
    
    /// Format text for putting pattern. If formattingReplacementChar is "*" then example may has value "**** - **** - ********". Default is ""
    public var formattingTemplate: String = ""
    /// Replacement symbol, it use for formattingTemplate as is as pattern for replacing. Default is "#"
    public var formattingReplacementChar: Character = "#"
    /// Allowable symbols for entering. Uses only if formattingTemplate is not empty. Default is "", that is all symbols.
    public var formattingEnteredCharacters: String = ""
    
    /// Not editable pattern part of the text. Defaults to "".
    public var rightPatternText: String = ""
    /// Not editable pattern part of the text. Defaults to "".
    public var leftPatternText: String = ""
    
    /// Font of the rightPatternText. Defaults to the bold font.
    public var patternTextFont: UIFont?
    /// Color of the rightPatternText. Defaults to the textColor.
    public var patternTextColor: UIColor?
    /// Need override standart font, because in iOS 10 changing attributedText rewrite font property
    public var enteredTextFont: UIFont?
    
    /// Constructor for phone putting
    public init(title: String? = nil, subtitle: String? = nil, placeholder: String? = nil,
                phoneValue: String? = nil, prefix: String = "",
                format: String, char: Character = "#")
    {
        super.init(title: title, placeholder: placeholder, value: phoneValue)
        self.subtitle = subtitle
        leftPatternText = prefix
        formattingTemplate = format
        formattingReplacementChar = char
        formattingEnteredCharacters = "0123456789"
        patternTextFont = BxInputSettings.standart.valueFont
        textSettings.keyboardType = .numberPad
    }
    
    /// Constructor for url putting
    public init(title: String? = nil, subtitle: String? = nil, placeholder: String? = nil,
                domainValue: String? = nil, prefix: String = "", sufix: String = "")
    {
        super.init(title: title, subtitle: subtitle, placeholder: placeholder, value: domainValue)
        leftPatternText = prefix
        rightPatternText = sufix
        textSettings.keyboardType = .URL
    }
    
    /// Return true if value for the row is empty
    override open var hasEmptyValue: Bool
    {
        if rightPatternText.isEmpty, leftPatternText.isEmpty {
            return super.hasEmptyValue
        }
        if let value = value {
            return value.isEmpty || value == leftPatternText + rightPatternText
        }
        return true
    }
    
}
