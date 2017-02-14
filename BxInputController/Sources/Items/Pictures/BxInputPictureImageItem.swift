//
//  BxInputPictureImageItem.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 08/02/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

public class BxInputPictureImageItem : BxInputPicture
{
    internal var image: UIImage
    
    public var iconSize: CGSize
    
    public var icon: UIImage {
        get { return image }
    }
    
    public init (image: UIImage, iconSize: CGSize){
        self.image = image
        self.iconSize = iconSize
    }
    
}
