/**
 *	@file BxInputBlockChecker.swift
 *	@namespace BxInputController
 *
 *	@details Cheker for row with custom block
 *	@date 31.07.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// Cheker for row with custom block
open class BxInputBlockChecker<Row : BxInputValueRow> : BxInputBaseRowChecker<Row>
{
    
    /// handler for checking value
    public var handler: ((_ row: Row) -> Bool)? = nil
    
    /// init from standart decorator with highlighted placeholder and subtitle, if its are defined
    convenience public init(row: Row, placeholder: String? = nil, subtitle: String? = nil, handler: ((_ row: Row) -> Bool)?) {
        let decorator = BxInputStandartErrorRowDecorator()
        decorator.placeholder = placeholder
        decorator.subtitle = subtitle
        self.init(row: row, decorator: decorator)
        self.handler = handler
    }
    
    /// checking method
    override open func isOK() -> Bool
    {
        if let handler = handler {
            return handler(row)
        }
        return false
    }
}
