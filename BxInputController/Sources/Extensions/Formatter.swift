//
//  Formatter.swift
//  BookedBy
//
//  Created by Sergey Balalaev on 10/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import Foundation

extension DateFormatter
{
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    public convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}

extension NumberFormatter
{
    public convenience init(style: NumberFormatter.Style) {
        self.init()
        self.numberStyle = style
    }
}
