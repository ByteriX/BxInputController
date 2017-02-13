/**
 *	@file BxInputPicture.swift
 *	@namespace BxInputController
 *
 *	@details Protocol allows shows items with picture
 *	@date 06.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Protocol allows shows items with picture
public protocol BxInputPicture: AnyObject
{
    
    /// image for showing in a row
    var icon: UIImage {get}
    
    /// size of the image for showing in a row
    var iconSize: CGSize {get}
    
}
