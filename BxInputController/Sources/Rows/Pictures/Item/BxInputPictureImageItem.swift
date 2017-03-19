/**
 *	@file BxInputPictureImageItem.swift
 *	@namespace BxInputController
 *
 *	@details Implementation picture item as UIImage owner. For example it may be photo from camera
 *	@date 08.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Implementation picture item as UIImage owner. For example it may be photo from camera
public class BxInputPictureImageItem : BxInputPictureItem
{
    /// this for storge icon
    internal var image: UIImage
    /// From BxInputPictureItem size of icon
    public var iconSize: CGSize
    /// From BxInputPictureItem icon
    public var icon: UIImage {
        get { return image }
    }
    
    public init (image: UIImage, iconSize: CGSize){
        self.image = image
        self.iconSize = iconSize
    }
    
}
