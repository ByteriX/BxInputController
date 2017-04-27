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
open class BxInputEmptyValueChecker<Row : BxInputValueRow> : BxInputBaseRowChecker<Row>
{
    /// init from standart decorator with highlighted placeholder and subtitle, if its are defined
    convenience init(row: Row, placeholder: String? = nil, subtitle: String? = nil) {
        self.init(row: row)
        let decorator = BxInputStandartErrorRowDecorator()
        decorator.placeholder = placeholder
        decorator.subtitle = subtitle
        self.decorator = decorator
    }
    
    /// checking method
    override open func isOK() -> Bool
    {
        return row.hasEmptyValue == false
    }
}
