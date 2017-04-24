/**
 *	@file BxInputEmptyValueChecker.swift
 *	@namespace BxInputController
 *
 *	@details Cheker for not empty value
 *	@date 22.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Cheker for not empty value
open class BxInputEmptyValueChecker : BxInputBaseRowChecker
{
    
    override open func isOK(row: BxInputRow) -> Bool
    {
        if let row = row as? BxInputValueRow {
            return row.hasEmptyValue == false
        }
        return false
    }
}
