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
public struct BxInputSettings
{
    /// it is default for all BxInputController objects in a Target
    public static var standart = BxInputSettings()
    
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
    /// The color of subtext in the subtitle label for a row
    public var subtitleColor: UIColor = UIColor.black
    /// The font of subtext in the title label for a row
    public var subtitleFont: UIFont = UIFont.systemFont(ofSize:  10)
    /// The color of text in the value field for a row
    public var valueColor: UIColor = UIColor.black
    /// The font of text in the value field for a row
    public var valueFont: UIFont = UIFont.systemFont(ofSize:  15)
    /// The color of placeholder in the value field for a row, the font is used from valueFont value.
    public var placeholderColor: UIColor? = nil
    
    /// height of cells for all rows, which don't use a dynamic size or the static size
    public var cellHeight: CGFloat? = 46
    /// height for all headers with all content type exclude view, which don't use a dynamic size or the static size
    public var headerHeight: CGFloat? = nil
    /// height for all footers with all content type exclude view, which don't use a dynamic size or the static size
    public var footerHeight: CGFloat? = nil
    /// seporator inset of all cells
    public var separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    /// margin of subtitle from bottom
    public var subtitleMargin: CGFloat = 2.0
    /// alignment of subtitle
    public var subtitleAlignment: NSTextAlignment = .left
    /// date format for showing value of the rows with date type
    public var dateFormat: DateFormatter = DateFormatter(dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
    
    // MARK: - this don't used for a future
    
    var indentWidth: CGFloat = 10 // tagWidth / lineShift analog
    
    // MARK: - enabled/disabled options:
    
    /// If it is true then visual with UI will be nothing, else uses disadledViewAplpha or changeViewEnableHandler. This has high priority. Default NO.
    var isNormalShowingDisadledCell: Bool = false
    /// If isNormalShowingDisadledCell == true then it ignored. It is doing possible change view from isEnabled status. Default is ignored.
    var changeViewEnableHandler: ((_ view: UIView, _ isEnabled: Bool) -> Void)? = nil
    /// If isNormalShowingDisadledCell == true or changeViewEnableHandler != nil then it ignored. Used for hidden showing view in cell when it need for showing disabled row. Value can be between 0..1
    var alphaForDisabledView: CGFloat = 0.5
    
    
    // MARK: - Strings values
    
    /// title of the back button on the keyboard panel
    public var backButtonTitle = "Up"
    /// title of the next button on the keyboard panel
    public var nextButtonTitle = "Down"
    /// title of the done button on the keyboard panel
    public var doneButtonTitle = "Done"
    
    /// Default initializer
    public init() {
        // all defined
    }
    
}
