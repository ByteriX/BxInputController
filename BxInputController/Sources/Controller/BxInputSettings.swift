/**
 *	@file BxInputSettings.swift
 *	@namespace BxInputController
 *
 *	@details settings of BxInputController for custom showing any controllers or concrete
 *	@date 09.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Settings of BxInputController for custom showing any controllers or concrete
open class BxInputSettings
{
    /// it is default for all BxInputController objects in a Target
    internal(set) open static var standart = BxInputSettings()
    
    // MARK: - Header/Footer
    
    /// The color of text in a header
    public var headerColor: UIColor = UIColor.darkGray
    /// The font of text in a header
    public var headerFont: UIFont = UIFont.systemFont(ofSize:  16)
    /// The color of text in a footer
    public var footerColor: UIColor = UIColor.lightGray
    /// The font of text in a footer
    public var footerFont: UIFont = UIFont.systemFont(ofSize:  12)
    
    // MARK: - Row/Cell
    
    /// it uses from selector rows, when user choose value then selector automatical will closed, if isAutodissmissSelector would be true
    public var isAutodissmissSelector: Bool = true
    /// The color of text in the title label for a row
    public var titleColor: UIColor = UIColor.black
    /// The font of text in the title label for a row
    public var titleFont: UIFont = UIFont.boldSystemFont(ofSize:  15)
    /// The color of text in the value field for a row
    public var valueColor: UIColor = UIColor.black
    /// The font of text in the value field for a row
    public var valueFont: UIFont = UIFont.systemFont(ofSize:  15)
    /// The color of placeholder in the value field for a row, the font is used from valueFont value.
    public var placeholderColor: UIColor? = nil
    
    /// height of cells for all rows, which don't use a dynamic size or the static size
    public var globalCellHeight: CGFloat? = 46
    /// seporator inset of all cells
    public var separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    /// date format for showing value of the rows with date type
    public var dateFormat: DateFormatter = DateFormatter(dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
    
    // MARK: - this don't used
    
    var minValueWidth: CGFloat = 80
    var indentWidth: CGFloat = 10 // tagWidth / lineShift analog
    var isNormalShowingDisadledCell: Bool = false
    var isFloatCellSize: Bool = false
    
    // MARK: - Strings values
    
    /// title of the back button on the keyboard panel
    public var backButtonTitle = "Up"
    /// title of the next button on the keyboard panel
    public var nextButtonTitle = "Down"
    /// title of the done button on the keyboard panel
    public var doneButtonTitle = "Done"
    
}
