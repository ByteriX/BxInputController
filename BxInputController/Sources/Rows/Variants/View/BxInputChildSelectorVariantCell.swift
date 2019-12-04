/**
 *	@file BxInputChildSelectorVariantCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for showing variant selector as data picker
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Delegate for BxInputChildSelectorVariantCell
public protocol BxInputChildSelectorVariantDelegate : UIPickerViewDelegate, UIPickerViewDataSource
{
    //
}

/// Cell for showing variant selector as data picker
open class BxInputChildSelectorVariantCell: UITableViewCell {

    /// delegate with backward call UIPickerViewDelegate, UIPickerViewDataSource
    public weak var delegate: BxInputChildSelectorVariantDelegate? = nil
    {
        didSet {
            variantPicker.delegate = delegate
            variantPicker.dataSource = delegate
        }
    }
    
    /// control for choosing variant
    @IBOutlet weak open var variantPicker: UIPickerView!
    
    
}
