//
//  BxInputSettings.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 09/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit


open class BxInputSettings
{
    internal(set) open static var standart = BxInputSettings()
    
    var headerColor: UIColor = UIColor.darkGray
    var headerFont: UIFont = UIFont.systemFont(ofSize:  16)
    
    var footerColor: UIColor = UIColor.lightGray
    var footerFont: UIFont = UIFont.systemFont(ofSize:  12)
    
    var isAutodissmissSelector: Bool = true
    
    var titleColor: UIColor = UIColor.black
    var valueColor: UIColor = UIColor.black
    var placeholderColor: UIColor = UIColor.lightGray
    
    var titleFont: UIFont = UIFont.boldSystemFont(ofSize:  15)
    var valueFont: UIFont = UIFont.systemFont(ofSize:  15)
    
    var minValueWidth: CGFloat = 80
    var indentWidth: CGFloat = 10 // tagWidth / lineShift analog
    var isNormalShowingDisadledCell: Bool = false
    var isFloatCellSize: Bool = false
    
    var dateFormat: DateFormatter = DateFormatter(dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
    
}
