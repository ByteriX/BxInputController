/**
 *	@file BxInputChildSelectorPicturesCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for selector a picture. This child cell places below parent cell
 *	@date 03.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit
import AssetsLibrary
import Photos

/// Cell for selector a picture. This child cell places below parent cell
public class BxInputChildSelectorPicturesCell: UITableViewCell {
    

    @IBOutlet weak open var valueTextField: UITextField!
    @IBOutlet weak open var selectedScrollView: UIScrollView!
    
    
    weak var rowData: BxInputSelectorPicturesRow!
    var selectedPictureViews: [BxInputSelectorPictureView] = []
    
    var size : CGSize = CGSize(width: 64, height: 64)
    var margin : CGFloat = 10
    
    let dataSource = BxInputSelectorPicturesLibraryDataSource()
    let picturesPanel = UIView()

}
