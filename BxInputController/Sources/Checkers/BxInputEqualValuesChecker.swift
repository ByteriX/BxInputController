import Foundation

/**
 *	@file BxInputEqualValuesChecker.swift
 *	@namespace BxInputController
 *
 *	@details Cheking two rows for equality string values
 *	@date 05.05.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Cheking two rows for equality values
open class BxInputEqualValuesChecker<Row> : BxInputBaseRowChecker<Row>
where Row : BxInputRow, Row : BxInputString
{
    internal var comparisonRow : Row
    
    /// init from standart decorator with highlighted placeholder and subtitle, if its are defined
    required public init(row: Row, comparisonRow: Row, placeholder: String? = nil, subtitle: String? = nil)
    {
        self.comparisonRow = comparisonRow
        super.init(row: row)
        let decorator = BxInputStandartErrorRowDecorator()
        decorator.placeholder = placeholder
        decorator.subtitle = subtitle
        self.decorator = decorator
    }
    
    /// checking method
    override open func isOK() -> Bool
    {
        return row.stringValue == comparisonRow.stringValue
    }
}
