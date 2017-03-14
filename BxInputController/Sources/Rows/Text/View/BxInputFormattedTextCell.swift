/**
 *	@file BxInputFormattedTextCell.swift
 *	@namespace BxInputController
 *
 *	@details Text cell for rows which have title & Formatted value
 *	@date 14.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxTextField

/// Text cell for rows which have title & Formatted value
open class BxInputFormattedTextCell: BxInputStandartTextCell {
    
    /// Formatted value for only BxInputFormattedTextRow
    open var formattedTextField: BxTextField! {
        return valueTextField as! BxTextField
    }

    override open func update(data: BxInputRow)
    {
        super.update(data: data)
        //
        if let formattedRow = data as? BxInputFormattedTextRow {
            formattedTextField.text = ""
            
            formattedTextField.formattingTemplate = formattedRow.formattingTemplate
            formattedTextField.formattingReplacementChar = formattedRow.formattingReplacementChar
            formattedTextField.formattingEnteredCharacters = formattedRow.formattingEnteredCharacters
            
            formattedTextField.rightPatternText = formattedRow.rightPatternText
            formattedTextField.leftPatternText = formattedRow.leftPatternText
            
            if let patternTextFont = formattedRow.patternTextFont {
                formattedTextField.patternTextFont = patternTextFont
            }
            if let patternTextColor = formattedRow.patternTextColor {
                formattedTextField.patternTextColor = patternTextColor
            }
            if let enteredTextFont = formattedRow.enteredTextFont {
                formattedTextField.enteredTextFont = enteredTextFont
            }
            
            
            formattedTextField.placeholderText = formattedRow.placeholder ?? ""
            formattedTextField.text = formattedRow.value
        }
    }
    
}
