/**
 *	@file BxInputFormattedTextRowBinder.swift
 *	@namespace BxInputController
 *
 *	@details Binder for BxInputFormattedTextRow subclasses
 *	@date 20.03.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Binder for BxInputFormattedTextRow subclasses
open class BxInputFormattedTextRowBinder<Row : BxInputFormattedTextRow, Cell : BxInputFormattedTextCell>: BxInputTextRowBinder<Row, Cell>
{
    /// call after common update for text attributes updating
    override open func update()
    {
        super.update()
        //
        guard let cell = cell else {
            return
        }
        cell.formattedTextField.text = ""
        
        cell.formattedTextField.formattingTemplate = row.formattingTemplate
        cell.formattedTextField.formattingReplacementChar = row.formattingReplacementChar
        cell.formattedTextField.formattingEnteredCharacters = row.formattingEnteredCharacters
        
        cell.formattedTextField.rightPatternText = row.rightPatternText
        cell.formattedTextField.leftPatternText = row.leftPatternText
        
        if let patternTextFont = row.patternTextFont {
            cell.formattedTextField.patternTextFont = patternTextFont
        }
        if let patternTextColor = row.patternTextColor {
            cell.formattedTextField.patternTextColor = patternTextColor
        }
        if let enteredTextFont = row.enteredTextFont {
            cell.formattedTextField.enteredTextFont = enteredTextFont
        }
        
        cell.formattedTextField.placeholderColor = owner?.settings.placeholderColor
        cell.formattedTextField.placeholderText = row.placeholder ?? ""
        cell.formattedTextField.text = row.value
    }
    
    override open func valueChanged(valueTextField: UITextField) {
        row.enteredValue = cell?.formattedTextField.enteredText
        super.valueChanged(valueTextField: valueTextField)
    }
    
}



