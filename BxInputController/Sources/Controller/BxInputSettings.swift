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
    public var headerColor: UIColor = secondaryLabel
    /// The font of text in a header
    public var headerFont: UIFont = UIFont.systemFont(ofSize:  16)
    /// The color of text in a footer
    public var footerColor: UIColor = tertiaryLabel
    /// The font of text in a footer
    public var footerFont: UIFont = UIFont.systemFont(ofSize:  12)
    
    // MARK: - Row/Cell
    
    /// it uses from selector rows, when user choose value then selector automatical will closed, if isAutodissmissSelector would be true
    public var isAutodissmissSelector: Bool = true
    /// The color of text in the title label for a row
    public var titleColor: UIColor = label
    /// The font of text in the title label for a row
    public var titleFont: UIFont = UIFont.boldSystemFont(ofSize:  15)
    /// The color of subtext in the subtitle label for a row
    public var subtitleColor: UIColor = label
    /// The font of subtext in the title label for a row
    public var subtitleFont: UIFont = UIFont.systemFont(ofSize:  10)
    /// The color of text in the value field for a row
    public var valueColor: UIColor = label
    /// The font of text in the value field for a row
    public var valueFont: UIFont = UIFont.systemFont(ofSize:  15)
    /// The color of placeholder in the value field for a row, the font is used from valueFont value.
    public var placeholderColor: UIColor? = placeholderText
    
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
    
    // MARK: - Decorator featurese BxInputStandartErrorRowDecorator
    
    /// The color for error marking. See BxInputStandartErrorRowDecorator when it used.
    public var errorColor: UIColor = UIColor.red
    /// If user put a incorrected value the field will shake
    public var isErrorHasShake: Bool = true
    /// When user put a incorrected value and should shown subtitle you can change that aligment, different with subtitleAlignment. If it is nil then will not change subtitleAlignment.
    public var errorSubtitleAlignment: NSTextAlignment? = .right
    
    // MARK: - this don't used for a future
    
    var indentWidth: CGFloat = 10 // tagWidth / lineShift analog
    
    // MARK: - enabled/disabled options:
    
    /// If it is true then visual with UI will be nothing, else uses disabledViewAplpha or changeViewEnableHandler. This has high priority. Default NO.
    public var isNormalShowingDisabledCell: Bool = false
    /// If isNormalShowingDisabledCell == true then it ignored. It is doing possible change view from isEnabled status. Default is ignored.
    public var changeViewEnableHandler: ((_ view: UIView, _ isEnabled: Bool) -> Void)? = nil
    /// If isNormalShowingDisabledCell == true or changeViewEnableHandler != nil then it ignored. Used for hidden showing view in cell when it need for showing disabled row. Value can be between 0..1
    public var alphaForDisabledView: CGFloat = 0.5
    
    
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

extension BxInputSettings {
    
    public static var label : UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor.black
        }
    }
    
    public static var secondaryLabel : UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor.darkGray
        }
    }
    
    public static var tertiaryLabel : UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiaryLabel
        } else {
            return UIColor.gray
        }
    }
    
    public static var quaternaryLabel : UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.quaternaryLabel
        } else {
            return UIColor.lightGray
        }
    }
    
    public static var placeholderText : UIColor? {
        if #available(iOS 13.0, *) {
            return UIColor.placeholderText
        } else {
            return nil
        }
    }
    
}
