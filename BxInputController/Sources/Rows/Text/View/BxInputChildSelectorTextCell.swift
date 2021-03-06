/**
 *	@file BxInputChildSelectorTextCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for selector Row with longest text string
 *	@date 02.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxObjC

/// Delegate for BxInputChildSelectorTextCell
public protocol BxInputChildSelectorTextDelegate : UITextViewDelegate
{
    
}

/// Cell for selector Row with longest text string
public class BxInputChildSelectorTextCell: UITableViewCell, BxInputTextMemoCellProtocol {
    
    /// delegate has backword call UITextViewDelegate
    public weak var delegate: BxInputChildSelectorTextDelegate? = nil
    {
        didSet {
            textView.delegate = delegate
        }
    }

    /// value editor control
    @IBOutlet public internal(set) var textView: BxTextView!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    public var bottomShift: CGFloat {
        return bottomConstraint.constant
    }
    
    public var topShift: CGFloat {
        return topConstraint.constant
    }
}
