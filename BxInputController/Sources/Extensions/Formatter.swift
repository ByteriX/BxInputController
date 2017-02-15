/**
 *	@file Formatter.swift
 *	@namespace BxInputController
 *
 *	@details Make work with Formatter classes easeyer
 *	@date 10.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import Foundation

/// making object extension
extension DateFormatter
{
    /// making from format string
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    /// making from style
    public convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}

/// making object extension
extension NumberFormatter
{
    /// making from style
    public convenience init(style: NumberFormatter.Style) {
        self.init()
        self.numberStyle = style
    }
}
