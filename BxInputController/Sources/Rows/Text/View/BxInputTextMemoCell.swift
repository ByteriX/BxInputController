/**
 *	@file BxInputTextMemoCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for Row with longest text string
 *	@date 01.08.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import BxObjC

/// Delegate for BxInputTextMemoCell
public protocol BxInputTextMemoCellDelegate : UITextViewDelegate
{
    
}

/// Cell for Row with longest text string
public class BxInputTextMemoCell: UITableViewCell {
    
    /// delegate has backword call UITextViewDelegate
    public weak var delegate: BxInputTextMemoCellDelegate? = nil
    {
        didSet {
            textView.delegate = delegate
        }
    }
    
    /// value editor control
    @IBOutlet var textView: BxTextView!
    
}
