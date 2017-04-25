/**
 *	@file BxInputCell.swift
 *	@namespace BxInputController
 *
 *	@details BxInputTitleCell is base cell protocol
 *	@date 24.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// BxInputTitleCell is base cell protocol with title
public protocol BxInputTitleCell : AnyObject
{
    /// caption of the row
    var titleLabel: UILabel! {get}
    /// caption of title for the row. This is only option field
    var subtitleLabel: UILabel? {get}
    /// for managment of position subtitle
    var subtitleBottomMargin: NSLayoutConstraint? {get}
}

/// Base cell protocol with TextField
public protocol BxInputFieldCell : BxInputTitleCell
{
    /// value for the row or a putting example
    var valueTextField: UITextField! {get}
}
