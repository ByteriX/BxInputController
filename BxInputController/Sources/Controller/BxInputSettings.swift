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
    
    public var headerColor: UIColor = UIColor.darkGray
    public var headerFont: UIFont = UIFont.systemFont(ofSize:  16)
    
    public var footerColor: UIColor = UIColor.lightGray
    public var footerFont: UIFont = UIFont.systemFont(ofSize:  12)
    
    public var isAutodissmissSelector: Bool = true
    
    public var titleColor: UIColor = UIColor.black
    public var valueColor: UIColor = UIColor.black
    public var placeholderColor: UIColor? = nil
    
    public var titleFont: UIFont = UIFont.boldSystemFont(ofSize:  15)
    public var valueFont: UIFont = UIFont.systemFont(ofSize:  15)
    
    // this not used
    var minValueWidth: CGFloat = 80
    var indentWidth: CGFloat = 10 // tagWidth / lineShift analog
    var isNormalShowingDisadledCell: Bool = false
    var isFloatCellSize: Bool = false
    
    public var dateFormat: DateFormatter = DateFormatter(dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
    
}
