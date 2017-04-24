/**
 *	@file BxInputCell.swift
 *	@namespace BxInputController
 *
 *	@details BxInputCell is base cell protocol
 *	@date 24.04.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// BxInputCell is base cell protocol
public protocol BxInputCell : AnyObject
{
    /// caption of the row
    var titleLabel: UILabel! {get}
    /// value for the row or a putting example
    var valueTextField: UITextField! {get}
}
