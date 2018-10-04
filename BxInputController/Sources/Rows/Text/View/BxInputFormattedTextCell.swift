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
        return valueTextField as? BxTextField
    }

    
    
}
