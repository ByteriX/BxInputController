/**
 *	@file BxInputSelectorTextCell.swift
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

public protocol BxInputSelectorTextDelegate : UITextViewDelegate
{
    
}

/// Cell for selector Row with longest text string
public class BxInputSelectorTextCell: UITableViewCell {
    
    public weak var delegate: BxInputSelectorTextDelegate? = nil
    {
        didSet {
            textView.delegate = delegate
        }
    }

    @IBOutlet var textView: UITextView!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
