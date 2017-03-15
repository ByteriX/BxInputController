/**
 *	@file BxInputSelectorVariantsCell.swift
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

public protocol BxInputSelectorVariantsDelegate : UIPickerViewDelegate, UIPickerViewDataSource
{
    //
}

/// Cell for showing variant selector as data picker
open class BxInputSelectorVariantsCell: UITableViewCell {

    @IBOutlet weak open var variantsPicker: UIPickerView!
    
    public weak var delegate: BxInputSelectorVariantsDelegate? = nil
    {
        didSet {
            variantsPicker.delegate = delegate
            variantsPicker.dataSource = delegate
        }
    }
    
    
}
